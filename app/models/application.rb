class Application < ApplicationRecord
  has_many :pets_applications
  has_many :pets, through: :pets_applications

  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true, numericality: true
  validates :description, presence: true
end
