/* eslint no-console:0 */

import 'babel-polyfill'

import $ from 'jquery'
import moment from 'moment'
import React from 'react'
import ReactDOM from 'react-dom'
import ImagesRoot from './components/ImagesRoot'
import LiveRoot from './components/LiveRoot'

import {
  BrowserRouter as Router,
  Route
} from 'react-router-dom'


if ($('#react-root').length > 0) {
  ReactDOM.render(
    <Router>
      <div>
        <Route path='/:name/images' component={ImagesRoot} />
        <Route path='/:name' component={LiveRoot} />
      </div>
    </Router>,
    $('#react-root')[0]
  )
}
