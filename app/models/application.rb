class Application < ApplicationRecord
  validates :name, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true, numericality: true
  validates :description, presence: true

  has_many :pet_applications
  has_many :applications, through: :pet_applications
end