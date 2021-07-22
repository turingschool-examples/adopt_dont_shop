class Application < ApplicationRecord
  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :zip_code, presence: true, numericality: true

  has_many :application_pets
  has_many :pets, through: :application_pets

  # def approved_pets(param)
  #   @application
  # end

  # def adopt_pet(add_pet)
  #   @application = Application.find(params[:id])
  #   application.pet = Pet.find(add_pet)
  #   pets << pet
  # end
end
