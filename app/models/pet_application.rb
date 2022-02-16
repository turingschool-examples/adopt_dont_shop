class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :applicant
  enum status: { "In Progress": 0, "Pending": 1, "Accepted": 2, "Rejected": 3 }
end
