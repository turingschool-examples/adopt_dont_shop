class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :street_prefix
      t.integer :street_number
      t.string :street_name
      t.string :street_type
      t.string :city
      t.string :state
      t.integer :zip_code
      t.string :description
      t.string :status

      t.timestamps
    end
  end
end
