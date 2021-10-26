class AddDetailsToApplicationPets < ActiveRecord::Migration[5.2]
  def change
    change_column_default :application_pets, :state, "Pending"
  end
end
