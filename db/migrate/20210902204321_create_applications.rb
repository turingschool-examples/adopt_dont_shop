class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.string :applicant_name
      t.string :applicant_street_address
      t.string :applicant_city
      t.string :applicant_state
      t.string :applicant_zipcode
      t.string :description
      t.string :status

      t.timestamps
    end
  end
end
