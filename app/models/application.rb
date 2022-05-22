class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets
  enum status:["In Progress", "Pending", "Accepted", "Rejected"]
  validates_presence_of :name
  validates_presence_of :street_address
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zip_code
  validates_presence_of :description
  
end
