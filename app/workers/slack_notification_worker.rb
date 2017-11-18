class SlackNotificationWorker
  include Sidekiq::Worker

  def perform(image_id)
    image = Image.find_by(id: image_id)
    return unless image

    webhook_url = image.space.space_setting&.slack_incoming_webhook_url
    return unless webhook_url

    payload = { text: '', attachments: [{image_url: image.url}] }

    conn = Faraday.new
    conn.post(
      webhook_url,
      {
        payload: payload.to_json
      }
    )
  end
end
