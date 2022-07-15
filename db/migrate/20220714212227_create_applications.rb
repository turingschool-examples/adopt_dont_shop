class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.string :name
      t.string :address_street
      t.string :address_city
      t.string :address_state
      t.integer :address_zip_code
      t.string :description
      t.string :status
      t.references :pet, foreign_key: true

      t.timestamps
    end
  end
end
