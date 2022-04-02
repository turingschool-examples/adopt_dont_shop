class DropPetApplicationsTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :pet_applications
  end
end
