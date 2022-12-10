class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  enum status: {"in progress": 0, "pending": 1, "Accepted": 2, "Rejected": 3}
end
