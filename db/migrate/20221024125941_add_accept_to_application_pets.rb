class AddAcceptToApplicationPets < ActiveRecord::Migration[5.2]
  def change
    add_column :application_pets, :accept, :bool
  end
end
