
window.addEventListener('load', function () {

  document.querySelectorAll('[data-vote-type]').forEach(function (item) {
    item.addEventListener('ajax:complete', function (e) {
      notice = document.querySelector('[data-flash-type="notice"]')
      console.log('e')
      console.log(notice)
      if (notice) {
        notice.textContent = JSON.parse(e.detail[0].response).notice
      } else {
        notice = document.createElement("div")
        notice.setAttribute('data-flash-type', 'notice')
        notice.textContent = JSON.parse(e.detail[0].response).notice
        document.querySelector('body').prepend(notice)
      }
    })
  })

  document.querySelectorAll('[data-vote-type]').forEach(function (item) {
    item.addEventListener('ajax:success', function (e) {
      response = e.detail[0]
      if (response.decision) {
        e = document.querySelector('[data-answer-id="' + response.answer + '"][data-answer-view="true"]')
        e.innerText = response.votes
      } else {
        e = document.querySelector('[data-answer-id="' + response.answer + '"][data-answer-view="false"]')
      }
      e.innerText = response.votes
    })
  })
})  