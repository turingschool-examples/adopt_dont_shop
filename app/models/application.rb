class Application < ApplicationRecord
  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true, numericality: true
  validates :description, presence: true

  has_many :pet_applications
  has_many :pets, through: :pet_applications

  # def add_pet(pet)
  #   PetApplication.create!(pet_id: pet.id, application_id: self.id)
  # end

end
