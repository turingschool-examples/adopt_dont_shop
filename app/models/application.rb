class Application < ApplicationRecord
  validates :name, :address, :city, :state, :zip, :description, presence: true
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  enum status: {"In Progress": 0, "Pending": 1, "Accepted": 2, "Rejected": 3}
end