class App < ApplicationRecord
  has_many :app_pets
  has_many :pets, through: :app_pets
  belongs_to :shelter
end

public
def adopt(pet)
  self.pets << pet
end