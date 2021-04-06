class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.string :applicant_name
      t.string :address
      t.string :statement, :default => " "
      t.string :status, :default => "In Progress"

      t.timestamps
    end
  end
end
