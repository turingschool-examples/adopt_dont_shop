class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  attribute :status, default: "Pending"
end