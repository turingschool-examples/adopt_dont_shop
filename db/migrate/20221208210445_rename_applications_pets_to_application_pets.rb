class RenameApplicationsPetsToApplicationPets < ActiveRecord::Migration[5.2]
  def change
    rename_table :applications_pets, :application_pets
  end
end
