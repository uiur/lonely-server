class AddIndexToPermissions < ActiveRecord::Migration[5.1]
  def change
    add_index :permissions, [:user_id, :space_id], unique: true
    add_index :permissions, :space_id
  end
end
