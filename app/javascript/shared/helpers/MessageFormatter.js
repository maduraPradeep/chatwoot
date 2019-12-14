class MessageFormatter {
  constructor(message) {
    this.message = message || '';
  }

  formatMessage() {
    const linkifiedMessage = this.linkify();
    return linkifiedMessage.replace(/\n/g, '<br>');
  }

  linkify() {
    if (!this.message) {
      return '';
    }
    const urlRegex = /(https?:\/\/[^\s]+)/g;
    return this.message.replace(
      urlRegex,
      url => `<a href="${url}" target="_blank">${url}</a>`
    );
  }

  get formattedMessage() {
    return this.formatMessage();
  }
}

export default MessageFormatter;
