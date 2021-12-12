class Application < ApplicationRecord
 has_many :adoptable_pets
 has_many :pets, through: :adoptable_pets
 validates :name, presence: true
 validates :street_address, presence: true
 validates :city, presence: true
 validates :state, presence: true
 validates :zipcode, presence: true
 validates :description, presence: true
end
