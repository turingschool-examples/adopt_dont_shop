class AddStatusToApplicationPets < ActiveRecord::Migration[5.2]
  def change
    add_column :application_pets, :status, :string
    add_timestamps :application_pets, null: false
  end
end
