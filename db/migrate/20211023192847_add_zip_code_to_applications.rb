class AddZipCodeToApplications < ActiveRecord::Migration[5.2]
  def change
    add_column :applications, :zip_code, :integer
  end
end
