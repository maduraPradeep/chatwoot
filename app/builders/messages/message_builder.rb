require 'open-uri'

# This class creates both outgoing messages from chatwoot and echo outgoing messages based on the flag `outgoing_echo`
# Assumptions
# 1. Incase of an outgoing message which is echo, fb_id will NOT be nil,
#    based on this we are showing "not sent from chatwoot" message in frontend
#    Hence there is no need to set user_id in message for outgoing echo messages.

module Messages
  class MessageBuilder
    attr_reader :response

    def initialize(response, inbox, outgoing_echo = false)
      @response = response
      @inbox = inbox
      @sender_id = (outgoing_echo ? @response.recipient_id : @response.sender_id)
      @message_type = (outgoing_echo ? :outgoing : :incoming)
    end

    def perform
      ActiveRecord::Base.transaction do
        build_contact
        build_message
      end
    rescue StandardError => e
      Raven.capture_exception(e)
      true
    end

    private

    def contact
      @contact ||= @inbox.contact_inboxes.find_by(source_id: @sender_id)&.contact
    end

    def build_contact
      return if contact.present?

      @contact = Contact.create!(contact_params)
      ContactInbox.create(contact: contact, inbox: @inbox, source_id: @sender_id)
    end

    def build_message
      @message = conversation.messages.new(message_params)
      (response.attachments || []).each do |attachment|
        @message.build_attachment(attachment_params(attachment))
      end
      @message.save!
    end

    def build_attachment; end

    def conversation
      @conversation ||= Conversation.find_by(conversation_params) || Conversation.create!(conversation_params)
    end

    def attachment_params(attachment)
      file_type = attachment['type'].to_sym
      params = { file_type: file_type, account_id: @message.account_id }

      if [:image, :file, :audio, :video].include? file_type
        params.merge!(file_type_params(attachment))
      elsif file_type == :location
        params.merge!(location_params(attachment))
      elsif file_type == :fallback
        params.merge!(fallback_params(attachment))
      end

      params
    end

    def file_type_params(attachment)
      {
        external_url: attachment['payload']['url'],
        remote_file_url: attachment['payload']['url']
      }
    end

    def location_params(attachment)
      lat = attachment['payload']['coordinates']['lat']
      long = attachment['payload']['coordinates']['long']
      {
        external_url: attachment['url'],
        coordinates_lat: lat,
        coordinates_long: long,
        fallback_title: attachment['title']
      }
    end

    def fallback_params(attachment)
      {
        fallback_title: attachment['title'],
        external_url: attachment['url']
      }
    end

    def conversation_params
      {
        account_id: @inbox.account_id,
        inbox_id: @inbox.id,
        contact_id: contact.id
      }
    end

    def message_params
      {
        account_id: conversation.account_id,
        inbox_id: conversation.inbox_id,
        message_type: @message_type,
        content: response.content,
        fb_id: response.identifier
      }
    end

    def contact_params
      begin
        k = Koala::Facebook::API.new(@inbox.channel.page_access_token) if @inbox.facebook?
        result = k.get_object(@sender_id) || {}
      rescue Exception => e
        result = {}
        Raven.capture_exception(e)
      end
      {
        name: "#{result['first_name'] || 'John'} #{result['last_name'] || 'Doe'}",
        account_id: @inbox.account_id,
        remote_avatar_url: result['profile_pic'] || nil
      }
    end
  end
end
