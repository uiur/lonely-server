class AddIndexToSpaces < ActiveRecord::Migration[5.1]
  def change
    add_index :spaces, :name, unique: true
  end
end
