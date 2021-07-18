class AdoptionApplication < ApplicationRecord
  has_many :adoption_application_pets
  has_many :pets, through: :adoption_application_pets
end
