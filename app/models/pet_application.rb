class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application
  validates :pet_status, inclusion: [nil, "Adoption Approved", "Adoption Rejected"]
end