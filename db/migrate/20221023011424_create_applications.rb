class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.string :applicant
      t.string :street
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :reason
      t.string :status

      t.timestamps
    end
  end
end
