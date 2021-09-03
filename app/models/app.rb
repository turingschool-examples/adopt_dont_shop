class App < ApplicationRecord
  has_many :app_pets
  has_many :pets, through: :app_pets
end
