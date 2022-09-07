class PetApplicant < ApplicationRecord
  enum status: ["In Progress", "Pending", "Accepted", "Rejected"]

  validates_presence_of :pet_id
  validates_presence_of :applicant_id
  validates_presence_of :status

  belongs_to :pet
  belongs_to :applicant

  def self.find_app_status(pet_id, applicant_id)
    where(applicant_id: applicant_id, pet_id: pet_id).order(created_at: :desc).first.status
  end

end