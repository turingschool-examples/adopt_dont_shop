class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.string :first_name
      t.string :last_name
      t.string :str_address
      t.string :city
      t.string :state
      t.bigint :zip
      t.string :home_description
      t.string :status

      t.timestamps
    end
  end
end
