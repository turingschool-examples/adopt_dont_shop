class Petition < ApplicationRecord
  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true, numericality: true

  has_many :petition_pets
  has_many :pets, through: :petition_pets

  def add_pet?
    status == "In Progress"
  end
end