class CreatePetForm < ActiveRecord::Migration[5.2]
  def change
    create_table :pet_forms do |t|
      t.references :pet, foreign_key: true
      t.references :form, foreign_key: true
    end
  end
end
