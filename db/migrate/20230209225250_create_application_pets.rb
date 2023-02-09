class CreateApplicationPets < ActiveRecord::Migration[5.2]
  def change
    create_table :application_pets do |t|
      t.belongs_to :pet, foreign_key: true
      t.belongs_to :application, foreign_key: true
      t.timestamps
    end
  end
end
