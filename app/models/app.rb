class App < ApplicationRecord
  enum status: {
    "In Progress": 0,
    "Pending": 1,
    "Accepted": 2,
    "Rejected": 3
  }

  has_many :app_pets
  has_many :pets, through: :app_pets
end 