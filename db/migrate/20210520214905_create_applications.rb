class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.references :applicant, foreign_key: true
      t.string :status
    end
  end
end
