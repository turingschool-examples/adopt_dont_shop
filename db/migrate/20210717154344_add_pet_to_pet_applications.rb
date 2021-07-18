class AddPetToPetApplications < ActiveRecord::Migration[5.2]
  def change
    add_reference :pet_applications, :pet, foreign_key: true
  end
end
