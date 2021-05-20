class Application < ApplicationRecord
  has_many :applicants
  has_many :application_pets
  has_many :pets, through: :application_pets
end