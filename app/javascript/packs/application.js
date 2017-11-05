/* eslint no-console:0 */

const $ = require('jquery')
const POLL_INTERVAL = 10 * 1000

if ($('#image').length > 0) {
  setInterval(() => {
    $('#image').attr('src', `/home/images/latest?t=${Date.now()}`)
  }, POLL_INTERVAL)
}

