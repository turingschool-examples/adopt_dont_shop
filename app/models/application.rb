class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets

  # def self.search_pets
  #   Pet.name.upcase.find(params[:search].upcase)
  #
  # end
end
