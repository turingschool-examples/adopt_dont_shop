class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets
  
  validates_presence_of :name, :street_address, :city, :state, :zip, :description
  
  # def search_pet(search)
  #   require 'pry'; binding.pry
  #   find
  # end
end