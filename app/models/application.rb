class Application < ApplicationRecord
  has_many :pets
  has_many :pets, through: :pet_applications


end
