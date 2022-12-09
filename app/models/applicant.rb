class Applicant < ApplicationRecord
  has_many :applicant_pets
  has_many :pets, through: :applicant_pets

  def full_address 
    "#{street_address}, #{city}, #{state} #{zip_code}"
  end
end