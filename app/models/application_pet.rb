class ApplicationPet < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  enum pet_status: [:undecided, :approved, :denied]
end
