# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Conversations::EventDataPresenter do
  let(:presenter) { described_class.new(conversation) }
  let(:conversation) { create(:complete_conversation) }

  describe '#lock_data' do
    it { expect(presenter.lock_data).to eq(id: conversation.display_id, locked: false) }
  end

  describe '#push_data' do
    let(:expected_data) do
      {
        meta: {
          sender: conversation.contact.push_event_data,
          assignee: conversation.assignee
        },
        id: conversation.display_id,
        messages: [],
        inbox_id: conversation.inbox_id,
        status: conversation.status_before_type_cast.to_i,
        timestamp: conversation.created_at.to_i,
        user_last_seen_at: conversation.user_last_seen_at.to_i,
        agent_last_seen_at: conversation.agent_last_seen_at.to_i,
        unread_count: 0
      }
    end

    it 'returns push event payload' do
      expect(presenter.push_data).to eq(expected_data)
    end
  end
end
