import * as React from 'react'
import * as moment from 'moment'
import request from '../lib/request'
import { RouteComponentProps } from 'react-router'
import debounce from 'lodash.debounce'

interface State {
  images: any[]
  lastPage: number
  loading: boolean
  stepInMinute: number
}

export default class ImagesRoot extends React.Component<RouteComponentProps<any>, State> {
  constructor (props) {
    super(props)

    this.state = {
      images: [],
      lastPage: 0,
      loading: false,
      stepInMinute: 0
    }
  }

  componentDidMount () {
    this.fetchMore(this.props.match.params.name)
  }

  reload () {
    const id = this.props.match.params.name

    this.setState({
      images: [],
      lastPage: 0,
      loading: false
    }, () => {
      this.fetchMore(id)
    })
  }

  async fetchMore (id: string) {
    if (this.state.loading) {
      return
    }

    this.setState({ loading: true })

    const params = {
      page: this.state.lastPage + 1
    }

    if (this.state.stepInMinute > 0) {
      Object.assign(params, {
        step_in_minute: this.state.stepInMinute
      })
    }

    const res = await request.get(`/${id}/images`, { params })

    const images = this.state.images.concat(res.data)

    this.setState({
      images,
      lastPage: this.state.lastPage + 1,
      loading: false
    })
  }

  stepOnChange (event) {
    this.setState({
      stepInMinute: Number(event.target.value)
    }, () => {
      this.reloadOnStepChange()
    })
  }

  reloadOnStepChange = debounce(() => this.reload(), 1000)

  render () {
    return (
      <section>
        <div className='step-chooser'>
          <input
            className='step-slider'
            type='range'
            min='0'
            max='60'
            step='10'
            value={this.state.stepInMinute}
            onChange={this.stepOnChange.bind(this)}
            />

          <p>
            {
              this.state.stepInMinute > 0 &&
                `every ${this.state.stepInMinute} minutes`
            }
          </p>
        </div>

        <div className='row'>
          {
            this.state.images.map(image => {
              return (
                <div key={image.timestamp} className='col-6'>
                  <a href={image.url}>
                    <img className='grid-image' src={image.url} />
                  </a>
                  <p>
                    { moment(image.timestamp).format('lll') }
                  </p>
                </div>
              )
            })
          }
        </div>

        {
          !this.state.loading &&
            <button
              className='btn btn-lg btn-primary btn-block'
              onClick={ () => this.fetchMore(this.props.match.params.name) }>
              More
            </button>
        }

      </section>
    )
  }
}
