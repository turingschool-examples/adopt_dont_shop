class CreatePetApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :pet_applications do |t|
      t.references :pet, foreign_key: true
      t.references :application, foreign_key: true
      t.string :description
      t.string :status

      t.timestamp :created_at
      t.timestamp :updated_at
    end
  end
end
