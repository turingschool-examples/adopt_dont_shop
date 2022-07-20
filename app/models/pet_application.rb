class PetApplication < ApplicationRecord
  validates :status, inclusion: ["In Progress", "Pending", "Accepted", "Rejected"]

  belongs_to :application
  belongs_to :pet
end
