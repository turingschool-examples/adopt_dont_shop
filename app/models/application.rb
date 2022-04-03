class Application < ApplicationRecord
  validates :name, presence: true
  validates :address, presence: true, numericality: true
  validates :city, presence: true 
  validates :state, presence: true 
  validates :zipcode, presence: true, numericality: true 
  has_many :pet_applications
  has_many :pets, through: :petapplications 
end 
