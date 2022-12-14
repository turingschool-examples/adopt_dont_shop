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
    pets.map { |pet| ApplicationPet.find_by_pet_and_app(pet.id, self.id) }
  end

  def uniq_app_pets_status
    order_app_pets_by_pets.pluck(:status).uniq
  end
end