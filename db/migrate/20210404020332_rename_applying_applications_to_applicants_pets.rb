class RenameApplyingApplicationsToApplicantsPets < ActiveRecord::Migration[5.2]
  def change
    rename_table :applying_applications, :applicants_pets
  end
end
