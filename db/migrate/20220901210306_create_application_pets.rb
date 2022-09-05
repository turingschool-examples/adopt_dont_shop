class CreateApplicationPets < ActiveRecord::Migration[5.2]
  def change
    create_table :application_pets do |t|
      t.references :application, foreign_key: true
      t.references :pet, foreign_key: true
      t.string :status
      t.timestamps
    end
  end
end
