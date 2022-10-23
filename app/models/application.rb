class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets

  validates :name, :street_address, :city, :state, :zipcode, :description, :status, :presence => true

  def add_pet(pet_id)
    self.pets << Pet.find(pet_id)
  end
end
