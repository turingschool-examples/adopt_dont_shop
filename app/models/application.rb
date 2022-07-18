class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, -> { distinct }, through: :pet_applications

  attribute :application_status, default: "In-Progress"

  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zipcode, presence: true

end