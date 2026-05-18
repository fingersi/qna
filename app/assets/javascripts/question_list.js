window.addEventListener('load', function () {

  var listContainer = document.querySelector('tbody.questions-list');
  if (!listContainer) {
    return;
  }

  App.cable.subscriptions.create('QuestionsChannel', {
    connected: function () {
    },

    received: function (data) {
      listContainer.insertAdjacentHTML('beforeend', data);
    }
  });
});