class Applicant < ApplicationRecord
  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true, numericality: true
  validates :applicant_bio, presence: true
  validates :application_status, presence: true
  has_many :pets
end
