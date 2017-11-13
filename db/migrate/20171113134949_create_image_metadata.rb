class CreateImageMetadata < ActiveRecord::Migration[5.1]
  def change
    create_table :image_metadata do |t|
      t.integer :image_id, unsigned: true, null: false
      t.integer :key,      unsigned: true, null: false
      t.text    :value
      t.index   [:image_id, :key], unique: true

      t.timestamps
    end
  end
end
