class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  enum status: {"In Progress" => 0, "Pending" => 1, "Approved" => 2, "Rejected" => 3}
end
