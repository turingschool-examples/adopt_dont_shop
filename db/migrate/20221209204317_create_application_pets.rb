class CreateApplicationPets < ActiveRecord::Migration[5.2]
  def change
    create_table :application_pets do |t|
      t.string :status
      t.references :pet, foreign_key: true
      t.references :application, foreign_key: true
      t.timestamps
    end
  end
end
