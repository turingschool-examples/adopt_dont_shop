class Applicant < ApplicationRecord
  enum status: [:in_progress, :pending, :accepted, :rejected]

  validates_presence_of :name, :street_address, :city, :state, :zip_code, :description, :status

  has_many :pet_applicants
  has_many :pets, through: :pet_applicants
end