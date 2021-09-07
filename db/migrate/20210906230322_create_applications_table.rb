class CreateApplicationsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.string :name
      t.integer :address
      t.string :street
      t.string :city
      t.string :state
      t.integer :zip_code
      t.string :description
      t.string :status

      t.timestamps
    end
  end
end
