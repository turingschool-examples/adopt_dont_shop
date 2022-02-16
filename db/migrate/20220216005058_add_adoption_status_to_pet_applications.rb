class AddAdoptionStatusToPetApplications < ActiveRecord::Migration[5.2]
  def change
    add_column :pet_applications, :adoption_status, :string
  end
end
