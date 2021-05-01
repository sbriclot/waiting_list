class CreateConfirmations < ActiveRecord::Migration[6.0]
  def change
    create_table :confirmations do |t|
      t.references :request, null: false, foreign_key: true
      t.string :validation_key, limit: 16, null: false
      t.integer :reply_delay, limit: 2, null: false
      t.datetime :replied_at

      t.timestamps
    end
  end
end
