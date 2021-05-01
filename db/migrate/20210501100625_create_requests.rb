class CreateRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :requests do |t|
      t.string :name, limit: 50, null: false
      t.string :email, limit: 50, null: false
      t.string :phone, limit: 10, null: false
      t.string :bio, limit: 400, null: false
      t.boolean :confirmed
      t.datetime :accepted_at
      t.datetime :expired_at

      t.timestamps
    end
  end
end
