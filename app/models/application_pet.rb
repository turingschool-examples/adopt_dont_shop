class ApplicationPet < ApplicationRecord
  belongs_to :pet
  belongs_to :application
  has_one :shelter, through: :pets
end
