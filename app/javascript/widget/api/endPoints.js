const sendMessage = content => ({
  url: `/api/v1/widget/messages${window.location.search}`,
  params: {
    message: {
      content,
    },
  },
});

const getConversation = () => ({
  url: `/api/v1/widget/messages${window.location.search}`,
});

const updateContact = id => ({
  url: `/api/v1/widget/messages/${id}${window.location.search}`,
});

export default {
  sendMessage,
  getConversation,
  updateContact,
};
