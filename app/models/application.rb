class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pet, through: :pet_applications
end
