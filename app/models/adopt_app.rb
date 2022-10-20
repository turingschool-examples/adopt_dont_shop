class AdoptApp < ApplicationRecord
  has_many :adopt_app_pets
  has_many :pets, through: :adopt_app_pets
end