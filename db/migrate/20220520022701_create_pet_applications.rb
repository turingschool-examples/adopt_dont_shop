class CreatePetApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :pet_applications do |t|
      t.references :pet_id, foreign_key: true
      t.references :application_id, foreign_key: true

      t.timestamps
    end
  end
end
