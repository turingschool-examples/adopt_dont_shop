class AddApplicationsToApplicationPets < ActiveRecord::Migration[5.2]
  def change
    add_reference :application_pets, :application, foreign_key: true
  end
end
