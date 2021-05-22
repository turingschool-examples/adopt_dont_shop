class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  validates_presence_of :name, :state, :city, :zip_code, :address, :description, :status
  # enum status: [:in_progress, :pending, :approved, :rejected]
end