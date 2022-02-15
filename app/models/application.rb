class Application < ApplicationRecord
  has_many :pet_application
  has_many :pets, through: :pet_application
end
