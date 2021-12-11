class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets

  attribute:description, :string, default: "Great Person"
  attribute:status, :string, default: "In Progress"
end
