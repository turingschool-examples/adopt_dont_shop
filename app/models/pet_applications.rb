class PetApplications < ApplicationRecord
  belongs_to :pet
  belongs_to :applications
  has_many :pets
  has_many :applications
end
