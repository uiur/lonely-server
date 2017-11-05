/* eslint no-console:0 */

const $ = require('jquery')
const POLL_INTERVAL = 10 * 1000

if ($('#live-image').length > 0) {
  const image = $('#live-image')
  const basePath = image.attr('src')

  setInterval(() => {
    image.attr('src', `${basePath}?t=${Date.now()}`)
  }, POLL_INTERVAL)
}
