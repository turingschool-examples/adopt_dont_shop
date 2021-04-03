class AddColumnsToApplications < ActiveRecord::Migration[5.2]
  def change
    add_column :applications, :street_address, :string
    add_column :applications, :city, :string
    add_column :applications, :state, :string
    add_column :applications, :zip_code, :string
    add_column :applications, :description, :string
    add_column :applications, :status, :string
  end
end
