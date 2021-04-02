class CreateApplicationPets < ActiveRecord::Migration[5.2]
  def change
    create_table :application_pets do |t|
      t.references :pet
      t.references :application

      t.timestamps
    end
  end
end
