class CreateConfirmations < ActiveRecord::Migration[6.0]
  def change
    create_table :confirmations do |t|
      t.references :request, foreign_key: true
      t.string :validation_key
      t.integer :reply_delay
      t.datetime :replied_at

      t.timestamps
    end
  end
end
