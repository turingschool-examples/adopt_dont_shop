class Applicant < ApplicationRecord
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :street_address
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :description
  validates_presence_of :status

  has_many :pet_applications
  has_many :pets, through: :pet_applications
end
