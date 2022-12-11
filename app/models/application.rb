class Application < ApplicationRecord
  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true, numericality: true
  validates :description, presence: true

  has_many :application_pets
  has_many :pets, through: :application_pets

  def address
    "#{street_address} #{city} #{state} #{zip_code}"
  end

  def pet_names
    self.pets.map do |pet| 
      pet.name
    end
  end
  
end