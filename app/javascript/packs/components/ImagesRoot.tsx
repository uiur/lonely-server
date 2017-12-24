import * as React from 'react'
import * as moment from 'moment'
import request from '../lib/request'
import { RouteComponentProps } from 'react-router'

interface State {
  images: any[]
  lastPage: number
  loading: boolean
}

export default class ImagesRoot extends React.Component<RouteComponentProps<any>, State> {
  constructor (props) {
    super(props)

    this.state = {
      images: [],
      lastPage: 0,
      loading: false
    }
  }

  componentDidMount () {
    this.fetchMore(this.props.match.params.name)
  }

  async fetchMore (id) {
    if (this.state.loading) {
      return
    }

    this.setState({ loading: true })

    const res = await request.get(`/${id}/images`, {
      params: {
        page: this.state.lastPage + 1
      }
    })

    const images = this.state.images.concat(res.data)

    this.setState({
      images,
      lastPage: this.state.lastPage + 1,
      loading: false
    })
  }

  render () {
    return (
      <section>
        <div className='row'>
          {
            this.state.images.map(image => {
              return (
                <div key={image.id} className='col-6'>
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

        <button
          className='btn btn-lg btn-primary btn-block'
          onClick={ () => this.fetchMore(this.props.match.params.name) }>
          More
        </button>
      </section>
    )
  }
}
