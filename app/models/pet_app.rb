class PetApp < ApplicationRecord
  belongs_to :pet
  belongs_to :applicant

  validates :pet_id, presence: true
  validates :applicant_id, presence: true
end