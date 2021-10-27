class Application < ApplicationRecord
  has_many :application_pets, dependent: :destroy
  has_many :pets, through: :application_pets
  validates :name, :address, :city, :state, :zip_code, presence: true
end
