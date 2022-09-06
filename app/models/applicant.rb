class Applicant < ApplicationRecord
  has_many :applicant_pets
  has_many :pets, through: :applicant_pets

  validates_presence_of :first_name, :last_name, :street_address, :city, :state, :zip, :description, :status
  validates :zip, numericality: true, length: { is: 5 }
  validates :status, inclusion: { in: ['In Progress', 'Pending', 'Approved', 'Rejected'] }
  
end 
