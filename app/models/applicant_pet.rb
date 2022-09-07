class ApplicantPet < ApplicationRecord
  belongs_to :applicant
  belongs_to :pet
  validates :approved, inclusion: [true, false], on: :update
  validates_associated :applicant, :pet

  def self.approved?(applicant_id, pet_id)
    where(applicant_id: (applicant_id)).where({pet_id: (pet_id)}).first.approved
    # would .pluck make more since then .first? and we could just call app_status then the .first.approved
  end

  def self.app_status(applicant_id, pet_id)
    where(applicant_id: (applicant_id)).where({pet_id: (pet_id)})
    # try a .pluck so we have the object this might help testing
  end
end 