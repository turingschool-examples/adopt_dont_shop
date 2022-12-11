class Application < ApplicationRecord
  validates_presence_of :name, :street_address, :city, :state, :zip_code
  has_many :application_pets
  has_many :pets, :through => :application_pets

  def pet_search(pet_name)
    Pet.where("name ILIKE ?", "%#{pet_name}%")
  end

  def has_pets?
    pets.count > 0
  end
end