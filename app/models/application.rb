class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  enum status: {
    "in progress": 0,
    "pending": 1,
    "approved": 2,
    "rejected": 3
  }

  validates_presence_of [:name, :street_address, :city, :state, :zip_code, :description]
end