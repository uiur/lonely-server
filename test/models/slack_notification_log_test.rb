require 'test_helper'

class SlackNotificationLogTest < ActiveSupport::TestCase
  test 'association' do
    space = FactoryBot.create(:space)
    log = space.slack_notification_logs.create!
    assert { log.space.present? }

    space.destroy


    assert { SlackNotificationLog.find_by(id: log.id).nil? }
  end
end
