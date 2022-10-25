class Applicant < ApplicationRecord 
  enum status: ["In Progress", "Pending", "Accepted", "Rejected" ]
  validates_presence_of :name, :street_address, :city, :state, :zip_code, :status # :description  

  has_many :pet_applicants 
  has_many :pets, through: :pet_applicants

  def add_pet(param)
    pets << Pet.find(param)
  end 
  
  

end