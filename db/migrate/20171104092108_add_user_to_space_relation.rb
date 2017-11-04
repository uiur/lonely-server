class AddUserToSpaceRelation < ActiveRecord::Migration[5.1]
  def change
    add_column :images, :space_id, :integer, null: false
    add_index :images, :space_id
  end
end
