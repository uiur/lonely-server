class AddVisibilityToSpace < ActiveRecord::Migration[5.1]
  def change
    add_column :spaces, :visibility, :integer, default: 0, null: false
  end
end
