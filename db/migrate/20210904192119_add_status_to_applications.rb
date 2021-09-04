class AddStatusToApplications < ActiveRecord::Migration[5.2]
  def change
    add_column :applications, :status, :string
    add_column :applications, :street, :string
    add_column :applications, :city, :string
    add_column :applications, :state, :string
    add_column :applications, :zip, :string
    add_column :applications, :description, :string
  end
end
