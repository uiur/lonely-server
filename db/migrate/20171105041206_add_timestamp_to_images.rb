class AddTimestampToImages < ActiveRecord::Migration[5.1]
  def change
    add_column :images, :timestamp, :datetime, null: false
  end
end
