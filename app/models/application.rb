class Application < ApplicationRecord
  has_many :pets
  validates_presence_of :name
  validates_presence_of :street_address
  validates_presence_of :city
  validates_presence_of :description
  validates :state, length: { maximum: 2 }
  validates :zip_code, numericality: true, length: { maximum: 5 }
  validates :status, inclusion: ["In Progress", "Pending", "Accepted", "Rejected"]

  
end