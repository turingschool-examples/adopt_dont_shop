class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.string :name
      t.string :street
      t.string :city
      t.string :state
      t.integer :zip
      t.string :status
      t.string :description
      t.references :pet, foreign_key: true

      t.timestamps
    end
  end
end
