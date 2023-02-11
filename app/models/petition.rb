class Petition < ApplicationRecord
  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true, numericality: true

  has_many :pets

  def add_pet(pet)
    pet.petition_id = self.id
    binding.pry
  end
end