class Application < ApplicationRecord
  validates :applicant_name, presence: true
  validates :street, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true, numericality: true

  has_many :application_pets
  has_many :pets, through: :application_pets
end
