class Application < ApplicationRecord
  validates :name, :street, :city, :state, :zip_code, presence: true
  has_many :pet_applications
  has_many :pets, through: :pet_applications
end