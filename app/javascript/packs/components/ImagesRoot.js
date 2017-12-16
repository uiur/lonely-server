import React from 'react'
import axios from 'axios'
import moment from 'moment'

const request = axios.create({
  headers: {
    'Accept': 'application/json',
    'Content-Type': 'application/json'
  }
})

export default class ImagesRoot extends React.Component {
  constructor (props) {
    super(props)

    this.state = {
      images: []
    }
  }

  componentDidMount () {
    this.fetch(this.props.match.params.name)
  }

  async fetch (id) {
    const res = await request.get(`/${id}/images`)

    this.setState({ images: res.data })
  }

  render (props) {
    return (
      <section>
        <div className='row'>
          {
            this.state.images.map(image => {
              return (
                <div key={ image.id } className='col-6'>
                  <a href={ image.url }>
                    <img className='grid-image' src={ image.url } />
                  </a>
                  <p>
                    { moment(image.timestamp).format('lll') }
                  </p>
                </div>
              )
            })
          }
        </div>
      </section>
    )
  }
}
