/* eslint no-console:0 */

const $ = require('jquery')
const moment = require('moment')
const POLL_INTERVAL = 10 * 1000

if ($('#live-image').length > 0) {
  const image = $('#live-image')

  const url = new URL(window.location.href)
  const basePath = url.pathname

  function update () {
    image.attr('src', `${basePath}/images/latest?t=${Date.now()}`)

    $.get(`${basePath}/images/latest.json`).then(data => {
      const timestamp = moment(data.created_at).format('lll')
      $('.live-image-timestamp').text(timestamp)
    }, err => {
      console.error(err)
    })
  }

  update()
  setInterval(update, POLL_INTERVAL)
}
