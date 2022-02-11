class Applicant < ApplicationRecord
  enum status: { "In Progress": 0, "Pending": 1, "Accepted": 2, "Rejected": 3 }

  has_many :pet_applications
  has_many :pets, through: :pet_applications
end
