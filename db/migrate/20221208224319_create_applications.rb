class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.string :human_name
      t.string :description
      t.string :street_address
      t.string :city
      t.string :state
      t.string :zip
      t.string :status

      t.timestamps
    end
  end
end
