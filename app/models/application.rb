class Application < ApplicationRecord
  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true
  validates :description, presence: true


  has_many :pet_applications
  has_many :pets, through: :pet_applications

  enum status: ["In progress", "Pending", "Accepted", "Rejected"]
end