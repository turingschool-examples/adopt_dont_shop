class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.string :applicant_name
      t.string :app_state
      t.string :app_city
      t.string :app_street
      t.string :app_zip_code
      t.string :description
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
