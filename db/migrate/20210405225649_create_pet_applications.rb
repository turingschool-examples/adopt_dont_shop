class CreatePetApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :pet_applications do |t|
      t.references :pets
      t.references :applications

      t.timestamps
    end
  end
end
