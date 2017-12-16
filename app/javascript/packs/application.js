/* eslint no-console:0 */

import 'babel-polyfill'

import $ from 'jquery'
import moment from 'moment'
import React from 'react'
import ReactDOM from 'react-dom'
import ImagesRoot from './components/ImagesRoot'

import {
  BrowserRouter as Router,
  Route,
  Link
} from 'react-router-dom'

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

if ($('#react-root').length > 0) {
  ReactDOM.render(
    <Router>
      <Route path='/:name/images' component={ImagesRoot}/>
    </Router>,
    $('#react-root')[0],
  )
}
