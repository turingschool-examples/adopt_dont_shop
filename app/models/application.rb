class Application < ApplicationRecord
  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true
  validates :description, presence: true
  validates :full_address, presence: true
  enum status: [:in_progress, :pending, :rejected, :approved]
  has_many :pet_application
  has_many :pet, through: :pet_application
end
