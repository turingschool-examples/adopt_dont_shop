class ApplicantPet < ApplicationRecord
  belongs_to :applicant
  belongs_to :pet

  def self.approved?(applicant_id, pet_id)
    where(applicant_id: (applicant_id)).where({pet_id: (pet_id)}).first.approved
  end

  def self.app_status(applicant_id, pet_id)
    where(applicant_id: (applicant_id)).where({pet_id: (pet_id)})
  end
end 