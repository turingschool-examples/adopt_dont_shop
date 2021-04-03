class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.string :applicant_name
      t.string :address
      t.string :statement
      t.string :pet_names
      t.string :status

      t.timestamps
    end
  end
end
