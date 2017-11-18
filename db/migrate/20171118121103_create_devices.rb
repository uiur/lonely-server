class CreateDevices < ActiveRecord::Migration[5.1]
  def change
    create_table :devices do |t|
      t.references :space, null: false
      t.string :token, null: false

      t.index :token, unique: true

      t.timestamps
    end
  end
end
