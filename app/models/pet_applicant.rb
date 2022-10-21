class PetApplicant < ApplicationRecord 
  enum status: ["In Progress", "Pending", "Accepted", "Rejected"]
  validates_presence_of :pet_id, :applicant_id, :status 
  belongs_to :pet 
  belongs_to :applicant 
end