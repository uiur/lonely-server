class CreateSpaceSettings < ActiveRecord::Migration[5.1]
  def change
    create_table :space_settings do |t|
      t.references :space, index: { unique: true }
      t.string :slack_incoming_webhook_url

      t.timestamps
    end
  end
end
