/* eslint no-console:0 */

const $ = require('jquery')
const POLL_INTERVAL = 10 * 1000

if ($('#image').length > 0) {
  const image = $('#image')
  const basePath = image.attr('src')

  setInterval(() => {
    image.attr('src', `${basePath}?t=${Date.now()}`)
  }, POLL_INTERVAL)
}
