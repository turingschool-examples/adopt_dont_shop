class AddColumnToApplicationPets < ActiveRecord::Migration[5.2]
  def change
    add_column :application_pets, :approved, :boolean
  end
end
