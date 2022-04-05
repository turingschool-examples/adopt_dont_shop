class ApplicationPet < ApplicationRecord
  belongs_to :pet
  belongs_to :application
  enum pet_status: [:undecided, :approved, :denied]

  has_one :shelter, through: :pets
end
