class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications
  validates :name, :street_address, :city, :state, :zip_code,  presence: true
end
