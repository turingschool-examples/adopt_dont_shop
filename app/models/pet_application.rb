class PetApplication < ApplicationRecord
    validates :applicant_id, presence: true
    validates :pet_id, presence: true

    belongs_to :pet #this might need to be destroyed later using ', dependent: :destroy'
    belongs_to :applicant #this might need to be destroyed later
end