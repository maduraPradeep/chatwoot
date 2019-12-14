# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Inbox do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:account_id) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:account) }

    it { is_expected.to belong_to(:channel) }

    it { is_expected.to have_many(:contact_inboxes).dependent(:destroy) }

    it { is_expected.to have_many(:contacts).through(:contact_inboxes) }

    it { is_expected.to have_many(:inbox_members).dependent(:destroy) }

    it { is_expected.to have_many(:members).through(:inbox_members).source(:user) }

    it { is_expected.to have_many(:conversations).dependent(:destroy) }

    it { is_expected.to have_many(:messages).through(:conversations) }
  end

  describe '#add_member' do
    let(:inbox) { FactoryBot.create(:inbox) }
    let(:user) { FactoryBot.create(:user) }

    it do
      expect(inbox.inbox_members.size).to eq(0)

      inbox.add_member(user.id)
      expect(inbox.reload.inbox_members.size).to eq(1)
    end
  end

  describe '#remove_member' do
    let(:inbox) { FactoryBot.create(:inbox) }
    let(:user) { FactoryBot.create(:user) }

    before { inbox.add_member(user.id) }

    it do
      expect(inbox.inbox_members.size).to eq(1)

      inbox.remove_member(user.id)
      expect(inbox.reload.inbox_members.size).to eq(0)
    end
  end

  describe '#facebook?' do
    let(:inbox) do
      FactoryBot.build(:inbox, channel: channel_val)
    end

    context 'when the channel type is Channel::FacebookPage' do
      let(:channel_val) { Channel::FacebookPage.new }

      it do
        expect(inbox.facebook?).to eq(true)
      end
    end

    context 'when the channel type is not Channel::FacebookPage' do
      let(:channel_val) { Channel::WebWidget.new }

      it { expect(inbox.facebook?).to eq(false) }
    end
  end
end
