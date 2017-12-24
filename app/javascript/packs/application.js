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
        <Route exact path='/:name' component={LiveRoot} />
        <Route path='/:name/images' component={ImagesRoot} />
      </div>
    </Router>,
    $('#react-root')[0]
  )
}
