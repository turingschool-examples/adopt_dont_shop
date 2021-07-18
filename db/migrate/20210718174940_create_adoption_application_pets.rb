class CreateAdoptionApplicationPets < ActiveRecord::Migration[5.2]
  def change
    create_table :adoption_application_pets do |t|
      t.references :pet, foreign_key: true
      t.references :adoption_application, foreign_key: true

      t.timestamps
    end
  end
end
