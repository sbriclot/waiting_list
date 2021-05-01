class CreateRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :requests do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.text :bio
      t.boolean :confirmed
      t.datetime :accepted_at
      t.datetime :expired_at

      t.timestamps
    end
  end
end
