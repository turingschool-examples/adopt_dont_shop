class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets
  
  validates_presence_of :name, :street_address, :city, :state, :zip
  # validates  :description, presence: true, if: :app_pet_create?

  # def self.app_pet_create?
  #   @app_pets.nil? == false
  # end
  
  # def search_pet(search)
  #   require 'pry'; binding.pry
  #   find
  # end
end