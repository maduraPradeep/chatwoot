json.id @message.id
json.content @message.content
json.inbox_id @message.inbox_id
json.conversation_id @message.conversation_id
json.message_type @message.message_type_before_type_cast
json.created_at @message.created_at.to_i
json.private @message.private
json.attachment @message.attachment.push_event_data if @message.attachment
