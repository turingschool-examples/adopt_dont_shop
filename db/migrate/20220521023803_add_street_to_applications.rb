class AddStreetToApplications < ActiveRecord::Migration[5.2]
  def change
    add_column :applications, :street, :string
    add_column :applications, :city, :string
    add_column :applications, :state, :string
    add_column :applications, :zip, :integer
  end
end
