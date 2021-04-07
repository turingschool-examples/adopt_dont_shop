class RenameApplicantsPets < ActiveRecord::Migration[5.2]
  def change
    rename_table :applicants_pets, :application_pets
    remove_reference :application_pets, :applicant
    add_reference :application_pets, :application
  end
end
