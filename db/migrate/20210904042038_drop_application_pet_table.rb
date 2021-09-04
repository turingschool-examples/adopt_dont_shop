class DropApplicationPetTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :application_pets
  end
end
