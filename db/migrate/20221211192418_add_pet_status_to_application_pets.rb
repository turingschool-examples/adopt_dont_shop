class AddPetStatusToApplicationPets < ActiveRecord::Migration[5.2]
  def change
    add_column :application_pets, :pet_status, :string, default: "Pending"
  end
end
