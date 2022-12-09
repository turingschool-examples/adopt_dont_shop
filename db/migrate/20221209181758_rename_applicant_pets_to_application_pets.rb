class RenameApplicantPetsToApplicationPets < ActiveRecord::Migration[5.2]
  def change
    rename_table :applicant_pets, :application_pets
  end
end
