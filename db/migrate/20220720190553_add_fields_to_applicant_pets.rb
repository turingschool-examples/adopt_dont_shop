class AddFieldsToApplicantPets < ActiveRecord::Migration[5.2]
  def change
    add_column :applicant_pets, :status, :string
  end
end
