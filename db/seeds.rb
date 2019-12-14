account = Account.create!(name: 'Acme Inc')

user = User.new(name: 'John', email: 'john@acme.inc', password: '123456', account: account, role: :administrator)
user.skip_confirmation!
user.save!

web_widget = Channel::WebWidget.create!(account: account, website_name: 'Acme', website_url: 'https://acme.inc')

inbox = Inbox.create!(channel: web_widget, account: account, name: 'Acme Support')
InboxMember.create!(user: user, inbox: inbox)

contact = Contact.create!(name: 'jane', email: 'jane@example.com', phone_number: '0000', account: account)
ContactInbox.create!(inbox: inbox, contact: contact, source_id: user.id)
conversation = Conversation.create!(account: account, inbox: inbox, status: :open, assignee: user, contact: contact)
Message.create!(content: 'Hello', account: account, inbox: inbox, conversation: conversation, message_type: :incoming)