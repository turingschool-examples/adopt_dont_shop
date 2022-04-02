class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :applications, :address, :street_address
  end
end
