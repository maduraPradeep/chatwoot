import MessageFormatter from '../MessageFormatter';

describe('#MessageFormatter', () => {
  describe('content with links', () => {
    it('should format correctly', () => {
      const message =
        'Chatwoot is an opensource tool\nSee more at https://www.chatwoot.com';
      expect(new MessageFormatter(message).formattedMessage).toEqual(
        'Chatwoot is an opensource tool<br>See more at <a href="https://www.chatwoot.com" target="_blank">https://www.chatwoot.com</a>'
      );
    });
  });
});
