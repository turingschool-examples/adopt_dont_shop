class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.string :applicant_name
      t.string :applicant_address
      t.string :description
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
