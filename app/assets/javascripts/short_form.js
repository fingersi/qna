
window.addEventListener("DOMContentLoaded", function () {
  var button = document.getElementById('button')
  if (button) {
    button.addEventListener('click', shortFormLinkHandler)
  }
})

function shortFormLinkHandler(event) {
  var form = document.getElementById('form')
  document.querySelectorAll('.edit-answer-link').forEach(function (item) {
    item.addEventListener('click', function () {
      console.log(item.innerHTML);
    });
  });

  if (form.classList.contains('hidden')) {
    form.classList.remove('hidden')
  } else {
    form.classList.add('hidden')
  }
}
