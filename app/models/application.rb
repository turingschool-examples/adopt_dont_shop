class Application < ApplicationRecord
  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true
  validates :description, presence: false
  validates :status, presence: true

  has_many :application_pet
  has_many :pets, through: :application_pet
end
