class CreatePetApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :pet_applications do |t|
      t.references :pet
      t.references :application
      t.timestamps
    end
  end
end
