class AddDetailsToApplicantPets < ActiveRecord::Migration[5.2]
  def change
    add_column :applicant_pets, :approved, :boolean, null: true
  end
end
