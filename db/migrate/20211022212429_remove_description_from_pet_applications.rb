class RemoveDescriptionFromPetApplications < ActiveRecord::Migration[5.2]
  def change
    remove_column :pet_applications, :description, :string
  end
end
