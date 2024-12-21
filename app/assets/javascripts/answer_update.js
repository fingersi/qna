
window.addEventListener('load', function () {

  document.querySelectorAll('.edit-answer-link').forEach(function (item) {
    item.preventDefault
    item.addEventListener('click', function (e) {
      form = document.getElementById("edit-answer-" + e.target.dataset.answerId)
      if (form.classList.contains('hidden')) {
        form.classList.remove('hidden')
      } else {
        form.classList.add('hidden')
      }
    })
  });
});