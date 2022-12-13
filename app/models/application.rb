class Application < ApplicationRecord
  validates :name, exclusion: [""]
  validates :street, exclusion: [""]
  validates :city, exclusion: [""]
  validates :state, exclusion: [""]
  validates :zip, exclusion: [""]
  validates :applicant_argument, exclusion: [""]

  has_many :application_pets
  has_many :pets, through: :application_pets

  def adopt_pet(pet)
    self.pets << pet
  end

  def order_app_pets_by_pets
    application_pets = []
    pets.each do |pet|
      application_pets << ApplicationPet.find_by_pet_and_app(pet.id, self.id)
    end
    application_pets
  end
end