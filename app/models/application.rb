
class Application < ApplicationRecord
  validates_presence_of :name, :address, :rationale, :status, :city, :state, :zipcode
  has_many :application_pets
  has_many :pets, through: :application_pets
end
