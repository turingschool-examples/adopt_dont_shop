class CreateShelterVeterinarians < ActiveRecord::Migration[5.2]
  def change
    create_table :shelter_veterinarians do |t|
      t.references :veterinarian, foreign_key: true
      t.references :shelter, foreign_key: true

      t.timestamps
    end
  end
end
