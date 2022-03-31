class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.string :name
      t.string :street_address
      t.string :city
      t.string :state
      t.string :zip_code
      t.text :reasons_to_approve
      t.string :status
      t.references :pet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
