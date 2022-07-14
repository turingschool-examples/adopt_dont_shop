class ApplicantPets < ActiveRecord::Migration[5.2]
  def change
    add_reference :pets, :applicant, foreign_key: true
  end
end
