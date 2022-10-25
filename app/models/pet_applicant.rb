class PetApplicant < ApplicationRecord
    belongs_to :pet
    belongs_to :applicant

    
    def self.find_petapplicant(applicant_id, pet_id)
     where(pet_id: pet_id).where(applicant_id: applicant_id)
    end
end