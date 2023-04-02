class Application < ApplicationRecord
  has_many :pet_applications
  enum status: ["In Progress", "Pending", "Accepted", "Rejected"]
end