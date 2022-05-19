class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.string :name
      t.string :street_address
      t.string :city
      t.integer :zip_code
      t.string :description
      t.string :pet_names
      t.string :application_status

      t.timestamps
    end
  end
end
