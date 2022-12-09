class Application < ApplicationRecord
  validates :name, exclusion: [""]
  validates :street, exclusion: [""]
  validates :city, exclusion: [""]
  validates :state, exclusion: [""]
  validates :zip, exclusion: [""]
  validates :applicant_argument, exclusion: [""]

  has_many :application_pets
  has_many :pets, through: :application_pets
end