class PetApplication < ApplicationRecord
  has_many :pet_application_pets
  has_many :pets, through: :pet_application_pets
end
