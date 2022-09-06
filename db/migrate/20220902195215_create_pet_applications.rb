class CreatePetApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :pet_applications do |t|
      t.references :pet, null: false, foreign_key: true
      t.references :application, null: false, foreign_key: true
      t.boolean :approved?, :default => false
      t.boolean :rejected?, :default => false

      t.timestamps
    end
  end
end
