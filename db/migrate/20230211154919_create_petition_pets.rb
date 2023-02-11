class CreatePetitionPets < ActiveRecord::Migration[5.2]
  def change
    create_table :petition_pets do |t|
      t.references :pet, foreign_key: true
      t.references :petition, foreign_key: true
      
      t.timestamps
    end
  end
end
