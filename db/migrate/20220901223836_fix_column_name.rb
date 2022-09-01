class FixColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :applications, :zip, :zip_code
  end
end
