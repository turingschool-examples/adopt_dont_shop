class CreatePetPetitions < ActiveRecord::Migration[5.2]
  def change
    create_table :pet_petitions do |t|
      t.references :pet, foreign_key: true
      t.references :petition, foreign_key: true
      t.string :good_home
      t.timestamps
    end
  end
end
