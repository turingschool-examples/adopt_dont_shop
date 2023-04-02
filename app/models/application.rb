class Application < ApplicationRecord
  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true
  validates :reason, presence: true
  validates :status, presence: true
  has_many :pet_applications
  has_many :pets, through: :pet_applications
  enum status: ["In Progress", "Pending", "Accepted", "Rejected"]
end