class AddApplicantToPetApplications < ActiveRecord::Migration[5.2]
  def change
    add_reference :pet_applications, :applicant, foreign_key: true
  end
end
