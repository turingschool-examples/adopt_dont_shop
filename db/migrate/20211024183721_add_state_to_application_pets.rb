class AddStateToApplicationPets < ActiveRecord::Migration[5.2]
  def change
    add_column :application_pets, :state, :string
  end
end
