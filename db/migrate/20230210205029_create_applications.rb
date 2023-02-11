class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.string :name
      t.string :address
      t.integer :status, default: 0
      t.text :description
      t.timestamps
      t.integer :zip_code
      t.string :state 
      t.string :city
    end
  end
end
