class PetApplicant < ApplicationRecord
  enum status: ["In Progress", "Pending", "Accepted", "Rejected"]

  validates_presence_of :pet_id
  validates_presence_of :applicant_id
  validates_presence_of :status

  belongs_to :pet
  belongs_to :applicant
end