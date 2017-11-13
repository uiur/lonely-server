class AddTimestampIndexToImages < ActiveRecord::Migration[5.1]
  def change
    add_index :images, :timestamp
  end
end
