class PetApplicant < ApplicationRecord
  belongs_to :pet
  belongs_to :applicant
end
