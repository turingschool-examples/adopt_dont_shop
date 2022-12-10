class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets

  validates :name, exclusion: { in: [nil] }
  validates :street_address, exclusion: { in: [nil] }
  validates :city, exclusion: { in: [nil] }
  validates :state, exclusion: { in: [nil] }
  validates :zip_code, exclusion: { in: [nil] }
  validates :description, exclusion: { in: [nil] }
  validates :status, presence: true
end