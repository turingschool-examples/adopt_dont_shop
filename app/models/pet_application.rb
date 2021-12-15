class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application
  attribute :approved, :string, default: "Pending"
end
