class AddStatusToApplicationPets < ActiveRecord::Migration[5.2]
  def change
    add_column :application_pets, :status, :string, default: "0"
  end
end
