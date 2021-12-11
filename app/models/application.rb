class Application < ApplicationRecord

  has_many :application_pets
  has_many :pets, through: :application_pets

  attribute:description, :string, default: "Great Person"
  attribute:status, :string, default: "In Progress"

  validates :name, presence: true
  validates :street, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true
end
