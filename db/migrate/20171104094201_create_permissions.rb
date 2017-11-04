class CreatePermissions < ActiveRecord::Migration[5.1]
  def change
    create_table :permissions do |t|
      t.integer :user_id, null: false
      t.integer :space_id, null: false

      t.timestamps
    end
  end
end
