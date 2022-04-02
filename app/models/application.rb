class Application < ApplicationRecord
  validates :name, presence: true
  validates :street, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true, numericality: true
  # validates :status, presence: true
  # validates :description, presence: true
  has_many :application_pets
  has_many :pets, through: :application_pets
end
