window.addEventListener("load", function () {
  const rootElement =
    document.querySelector(".question-show[data-question-id]") ||
    document.querySelector(".answer-show[data-question-id]");

  if (!rootElement) return;

  const questionId = rootElement.dataset.questionId;

  if (!window.App || !App.cable) return;

  App.cable.subscriptions.create(
    { channel: "CommentsChannel", question_id: questionId },
    {
      connected() {
      },

      received(data) {

        const temp = document.createElement("tbody");
        temp.innerHTML = data;
        const newComment = temp.firstElementChild;
        if (!newComment) return;

        const { commentableType, commentableId } = newComment.dataset;
        if (!commentableType || !commentableId) return;

        const selector = `.comments[data-commentable-type="${commentableType}"][data-commentable-id="${commentableId}"]`;
        const commentsContainer = document.querySelector(selector);
        

        if (!commentsContainer) {
          return;
        }

        commentsContainer.appendChild(newComment);
      },
    }
  );
});