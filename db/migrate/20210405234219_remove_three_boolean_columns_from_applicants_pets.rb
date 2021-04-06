class RemoveThreeBooleanColumnsFromApplicantsPets < ActiveRecord::Migration[5.2]
  def change
    remove_column :applicants_pets, :pending
    remove_column :applicants_pets, :accepted
    remove_column :applicants_pets, :rejected
  end
end
