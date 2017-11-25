require 'test_helper'

class SlackNotificationWorkerTest < ActiveSupport::TestCase
  setup do
    @image = FactoryBot.create(:image)
  end

  # TODO: test url format
  test 'webhook url exists' do
    @image.space.create_space_setting!(
      slack_incoming_webhook_url: 'https://hooks.slack.com/foobar'
    )

    stub_request(:post, /hooks.slack.com/)
      .to_return(status: 200)

    assert { @image.space.slack_notification_logs.count == 0 }

    worker = SlackNotificationWorker.new
    worker.perform(@image.id)

    assert { @image.space.slack_notification_logs.count == 1 }
  end

  test 'setting does not exist' do
    assert { @image.space.space_setting.nil? }

    worker = SlackNotificationWorker.new
    worker.perform(@image.id)
  end

  test '#should_notify?' do
    image = FactoryBot.create(:image)

    assert { SlackNotificationWorker.should_notify?(image) }

    image.space.slack_notification_logs.create!
    assert { SlackNotificationWorker.should_notify?(image) == false }
  end
end
