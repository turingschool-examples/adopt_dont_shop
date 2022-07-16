class AddPetStatusToPetApplications < ActiveRecord::Migration[5.2]
  def change
      add_column :pet_applications, :pet_status, :string
  end
end
