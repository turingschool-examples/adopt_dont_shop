class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.string :fname
      t.string :lname
      t.string :street_address
      t.string :city
      t.string :state
      t.integer :zip
      t.string :good_home_argument
      t.string :status

      t.timestamps
    end
  end
end
