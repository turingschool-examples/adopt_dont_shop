class Application < ApplicationRecord
  validates_presence_of :name, :street_address, :city, :state, :zip_code
  has_many :application_pets
  has_many :pets, :through => :application_pets
end