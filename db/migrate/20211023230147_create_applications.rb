class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.string :applicant_name
      t.string :street_address
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :application_status
      t.text :why

      t.timestamps
    end
  end
end
