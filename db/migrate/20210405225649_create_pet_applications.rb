class CreatePetApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :pet_applications do |t|
      t.references :pets
      t.references :owner_applications
      t.string :approve_status

      t.timestamps
    end
  end
end
