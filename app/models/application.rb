class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets

  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, :length => { :is => 5 }, presence: true
  validates :status, presence: true
  validates :description, presence: true
end
