import * as React from 'react'
import { RouteComponentProps } from 'react-router'
import * as moment from 'moment'

import request from '../lib/request'

interface Props extends RouteComponentProps<any> {
}

interface State {
  image?: any
}


export default class LiveRoot extends React.Component<Props, State> {
  static POLL_INTERVAL = 10 * 1000
  pollingTimer: number

  constructor (props) {
    super(props)
    this.state = { image: null }
  }

  async update () {
    const id = this.props.match.params.name
    request.get(`/${id}/images/latest.json`).then(res => {
      this.setState({ image: res.data })
    }, err => {
      console.error(err)
    })
  }

  componentDidMount () {
    this.pollingTimer = window.setInterval(this.update.bind(this), LiveRoot.POLL_INTERVAL)
    this.update()
  }

  componentWillUnmount () {
    window.clearInterval(this.pollingTimer)
  }

  render () {
    return (
      <section className='row align-items-center justify-content-center live-container'>
        {
          this.state.image &&
            <div className='col-12'>
              <a href={this.state.image.url} target='_blank'>
                <img id='live-image' src={this.state.image.url} />
              </a>
              <p className='live-image-timestamp'>{moment(this.state.image.created_at).format('lll')}</p>
            </div>
        }
      </section>
    )
  }
}
