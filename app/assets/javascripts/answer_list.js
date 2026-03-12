document.addEventListener('DOMContentLoaded', () => {

  var questionElement = document.querySelector('[data-question-id]');
  var loggedIn = document.body.dataset.loggedIn === 'true';
  var currentUserId = document.body.dataset.currentUserId;

  if (currentUserId) {
    showOwnEditButtons(currentUserId)
    showSetBestBtns(currentUserId)
    showLikeBtns(currentUserId)
  }

  var answersTableBody = document.querySelector('div.answers table tbody');
  if (!answersTableBody) {
    return;
  }

  var questionElement = document.querySelector('[data-question-id]');
  if (!questionElement) {
    return;
  }
  var questionId = questionElement.getAttribute('data-question-id');

  App.cable.subscriptions.create(
    { channel: 'AnswersChannel', question_id: questionId },
    {
      connected: function () {
      },

      received: function (data) {
        if (!data || !data.html) {
          return;
        }

        answersTableBody.insertAdjacentHTML('beforeend', data.html);

        if (loggedIn) {
          showOwnEditButtons(currentUserId)
          showSetBestBtns(currentUserId)
          showLikeBtns(currentUserId)
        } else {
          var lastRow = answersTableBody.lastElementChild;
          if (!lastRow) return;

          var loginOnlyNodes = lastRow.querySelectorAll('[data-login="true"]');
          loginOnlyNodes.forEach(function (node) {
            node.remove();
          });
        }
      }
    }
  );
});

function showOwnEditButtons(currentUserId) {
  if (!currentUserId) return;
  var editBtns = document.querySelectorAll('a.hidden[data-label="edit"]');
  if (editBtns.length === 0) return;
  editBtns.forEach(function (btn) {
    var authorId = btn.getAttribute('data-author-id');
    if (authorId === currentUserId) {
      btn.classList.remove('hidden');
    } 
  });
}

function showSetBestBtns(currentUserId) {
  var setBestBtns = document.querySelectorAll('a.hidden[data-label="setbest"]');
  if (setBestBtns.length === 0) return;
  setBestBtns.forEach(function (btn) {
    var authorId = btn.getAttribute('data-author-id');
    if (authorId === currentUserId) {
      btn.classList.remove('hidden');
    } 
  });
}

function showLikeBtns(currentUserId) {
  var setBestBtns = document.querySelectorAll('td.hidden[data-answer-author-id]');
  if (setBestBtns.length === 0) return;
  setBestBtns.forEach(function (btn) {
    var authorId = btn.getAttribute('data-answer-author-id');
    if (authorId != currentUserId) {
      btn.classList.remove('hidden');
    } 
  });
}


