class Applicant < ApplicationRecord
  has_many :applicant_pets
  has_many :pets, through: :applicant_pets
  
  validates :first_name, presence: true, allow_blank: false
  validates :last_name, presence: true, allow_blank: false
  validates :street_address, presence: true, allow_blank: false
  validates :city, presence: true, allow_blank: false
  validates :state, presence: true, allow_blank: false
  validates :zip, presence: true, allow_blank: false
  validates :description, presence: true, allow_blank: false
  validates :status, presence: true, allow_blank: false
  
end 
