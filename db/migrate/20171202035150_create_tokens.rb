class CreateTokens < ActiveRecord::Migration[5.1]
  def change
    create_table :tokens do |t|
      t.string :secret, null: false
      t.references :space
      t.integer :token_type, null: false, unsigned: true
      t.jsonb :value

      t.timestamps
    end
  end
end
