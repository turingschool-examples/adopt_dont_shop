class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications
end
