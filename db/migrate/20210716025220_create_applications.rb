class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.string :applicant_lastname
      t.string :applicant_firstname
      t.string :applicant_address
      t.string :applicant_city
      t.string :applicant_state
      t.string :applicant_zipcode
      t.string :applicant_description
      t.string :status

      t.timestamps
    end
  end
end
