import consumer from "./consumer"

consumer.subscriptions.create("AnswersChannel", {
  connected() {
  },

  disconnected() {
  },

  received(data) {
  }
});
