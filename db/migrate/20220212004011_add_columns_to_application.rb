class AddColumnsToApplication < ActiveRecord::Migration[5.2]
  def change
    add_column :applications, :street_address, :string
    add_column :applications, :city, :string
    add_column :applications, :state, :string
    add_column :applications, :zip_code, :string
    remove_column :applications, :address
  end
end
