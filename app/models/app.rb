class App < ApplicationRecord
  validates :name, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :status, presence: true
  validates :zip, presence: true, numericality: true

  enum status: {
    "In Progress": 0,
    "Pending": 1,
    "Accepted": 2,
    "Rejected": 3
  }
  has_many :app_pets
  has_many :pets, through: :app_pets
end 