class CreateAdoptAppPets < ActiveRecord::Migration[5.2]
  def change
    create_table :adopt_app_pets do |t|
      t.references :pet, foreign_key: true
      t.references :adopt_app, foreign_key: true
    end
  end
end
