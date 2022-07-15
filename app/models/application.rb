class Application < ApplicationRecord
  validates :name, presence: true
  validates :address, presence: true
  validates :description, presence: true
  validates :status, presence: true
  validates :zip, presence: true
  has_many :application_pets
  has_many :pets, through: :application_pets
end
