class CreatePetApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :pet_applications do |t|
      t.references :pet, null: false, foreign_key: true
      t.references :application, null: false, foreign_key: true
    end
  end
end
