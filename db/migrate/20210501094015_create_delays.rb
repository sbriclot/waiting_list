class CreateDelays < ActiveRecord::Migration[6.0]
  def change
    create_table :delays do |t|
      t.string :name, limit: 30
      t.integer :value, limit: 2
      t.string :description, limit: 150

      t.timestamps
    end
  end
end
