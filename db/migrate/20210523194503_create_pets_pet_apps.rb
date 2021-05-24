class CreatePetsPetApps < ActiveRecord::Migration[5.2]
  def change
    create_table :pets_pet_apps do |t|
      t.references :pet_application, foreign_key: true
      t.references :pet, foreign_key: true
      t.timestamps
    end
  end
end
