class PetApplicant < ApplicationRecord
  validates_presence_of :pet_id
  validates_presence_of :applicant_id

  belongs_to :pet
  belongs_to :applicant
end