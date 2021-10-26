class RemovePetIdFromPetApplications < ActiveRecord::Migration[6.1]
  def change
    remove_column :pet_applications, :pet_id
  end
end
