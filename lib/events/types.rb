# frozen_string_literal: true

module Events::Types
  CONVERSATION_CREATED = 'conversation.created'
  CONVERSATION_RESOLVED = 'conversation.resolved'
  CONVERSATION_READ = 'conversation.read'

  MESSAGE_CREATED = 'message.created'
  FIRST_REPLY_CREATED = 'first.reply.created'
  CONVERSATION_REOPENED = 'conversation.reopened'
  CONVERSATION_LOCK_TOGGLE = 'conversation.lock_toggle'
  ASSIGNEE_CHANGED = 'assignee.changed'

  ACCOUNT_CREATED = 'account.created'
  ACCOUNT_DESTROYED = 'account.destroyed'

  AGENT_ADDED = 'agent.added'
  AGENT_REMOVED = 'agent.removed'

  SUBSCRIPTION_CREATED = 'subscription.created'
  SUBSCRIPTION_REACTIVATED = 'subscription.reactivated'
  SUBSCRIPTION_DEACTIVATED = 'subscription.deactivated'
end
