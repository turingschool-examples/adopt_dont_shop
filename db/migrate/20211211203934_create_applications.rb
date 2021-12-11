class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.string :applicant_name
      t.string :address
      t.string :city
      t.string :state
      t.integer :zip_code
      t.string :reason
      t.string :status

      t.timestamps
    end
  end
end
