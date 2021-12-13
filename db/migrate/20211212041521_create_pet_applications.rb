class CreatePetApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :pet_applications do |t|
      t.references :pet, foreign_key: true
      t.references :application_form, foreign_key: true

      t.timestamps
    end
  end
end
