class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  enum status: {"In Progress" => 0, "Pending" => 1, "Approved" => 2, "Rejected" => 3}
end
