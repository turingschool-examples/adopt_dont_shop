class CreatePetApp < ActiveRecord::Migration[5.2]
  def change
    create_table :pet_apps do |t|
      t.references :shelters, foreign_key: true
      t.references :pets, foreign_key: true
    end
  end
end
