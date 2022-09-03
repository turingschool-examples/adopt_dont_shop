class Application < ApplicationRecord
  validates :fname, presence: true
  validates :lname, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true, numericality: { only_integer: true }
  validates :status, inclusion: ["In Progress", "Pending", "Accepted", "Rejected"]
  # validates :id, presence: true, numericality: { only_integer: true }

  has_many :pet_applications
  has_many :pets, through: :pet_applications
end