class CreateLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :logs do |t|
      t.references :request, foreign_key: true
      t.string :task
      t.string :added_by

      t.timestamps
    end
  end
end
