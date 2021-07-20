class PetApplicant < ApplicationRecord
  belongs_to :pet
  belongs_to :applicant

  def self.find_by_parents(pet_id, applicant_id)
    #potentially use find_by
    PetApplicant.find_by(pet_id: pet_id, applicant_id: applicant_id)
  end
end
