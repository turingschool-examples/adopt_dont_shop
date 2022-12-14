class ApplicationPet < ApplicationRecord
  belongs_to :pet
  belongs_to :application
  attribute :status, :string, default: "Pending"
end