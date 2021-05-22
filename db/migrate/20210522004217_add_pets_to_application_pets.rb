class AddPetsToApplicationPets < ActiveRecord::Migration[5.2]
  def change
    add_reference :application_pets, :pet, foreign_key: true
  end
end
