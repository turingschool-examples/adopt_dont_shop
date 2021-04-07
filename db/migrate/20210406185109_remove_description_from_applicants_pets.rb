class RemoveDescriptionFromApplicantsPets < ActiveRecord::Migration[5.2]
  def change
    remove_column :applicants_pets, :description
  end
end
