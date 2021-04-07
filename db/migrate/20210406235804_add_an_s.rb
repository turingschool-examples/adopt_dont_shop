class AddAnS < ActiveRecord::Migration[5.2]
  def change
    rename_table :application_pets, :applications_pets
  end
end
