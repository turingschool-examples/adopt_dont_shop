class AddCityToApplications < ActiveRecord::Migration[5.2]
  def change
    add_column :applications, :city, :string
    add_column :applications, :state, :string
    add_column :applications, :zipcode, :string
  end
end
