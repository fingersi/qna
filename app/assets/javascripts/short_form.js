

window.onload = function () {
  var button = document.getElementById('button')
  if (button) {
    button.addEventListener('click', shortFormLinkHandler)
  }
}
function shortFormLinkHandler(event) {
  var form = document.getElementById('form')
  if (form.classList.contains('hidden')) {
    form.classList.remove('hidden')
  } else {
    form.classList.add('hidden')
  }
}
