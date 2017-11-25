class CreateSlackNotificationLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :slack_notification_logs do |t|
      t.references :space
      t.timestamps

      t.index :created_at
    end
  end
end
