class AddStreetAddressToApplications < ActiveRecord::Migration[5.2]
  def change
    add_column :applications, :street_address, :string
  end
end
