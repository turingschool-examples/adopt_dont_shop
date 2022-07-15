class Applicant < ApplicationRecord
  validates :name, presence: true
  validates :address, presence: true
  validates :description, presence: true
  validates :status, presence: true
  validates :zip, presence: true
  has_many :applicant_pets
  has_many :pets, through: :applicant_pets
end
