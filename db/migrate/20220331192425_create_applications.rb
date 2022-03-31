class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.string :name
      t.string :full_address
      t.string :description
      t.string :pet_names
      t.string :status

      t.timestamps
    end
  end
end
