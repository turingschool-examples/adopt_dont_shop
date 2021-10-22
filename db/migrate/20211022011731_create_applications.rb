class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.string :name
      t.string :address
      t.string :description
      t.string :names_of_pets
      t.string :status

      t.timestamps
    end
  end
end
