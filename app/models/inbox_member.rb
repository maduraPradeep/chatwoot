# == Schema Information
#
# Table name: inbox_members
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  inbox_id   :integer          not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_inbox_members_on_inbox_id  (inbox_id)
#

class InboxMember < ApplicationRecord
  validates :inbox_id, presence: true
  validates :user_id, presence: true

  belongs_to :user
  belongs_to :inbox

  after_create :add_agent_to_round_robin
  after_destroy :remove_agent_from_round_robin

  private

  def add_agent_to_round_robin
    Redis::Alfred.lpush(round_robin_key, user_id)
  end

  def remove_agent_from_round_robin
    Redis::Alfred.lrem(round_robin_key, user_id)
  end

  def round_robin_key
    format(Constants::RedisKeys::ROUND_ROBIN_AGENTS, inbox_id: inbox_id)
  end
end
