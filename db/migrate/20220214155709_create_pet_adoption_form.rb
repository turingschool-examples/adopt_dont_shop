class CreatePetAdoptionForm < ActiveRecord::Migration[5.2]
  def change
    create_table :pet_adoption_forms do |t|
      t.references :adoption_form, foreign_key: true
      t.references :pet, foreign_key: true
    end
  end
end
