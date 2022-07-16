class Applicant < ApplicationRecord

  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true

  has_many :applicant_pets
  has_many :pets, :through => :applicant_pets


end