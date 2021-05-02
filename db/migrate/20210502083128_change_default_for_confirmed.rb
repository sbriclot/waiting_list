class ChangeDefaultForConfirmed < ActiveRecord::Migration[6.0]
  def change
    change_column_default :requests, :confirmed, false
  end
end
