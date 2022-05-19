class CreatePetApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :pet_applications do |t|
      t.references :pets, foreign_key: true
      t.references :applications, foreign_key: true

      t.timestamps
    end
  end
end
