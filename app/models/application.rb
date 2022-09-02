class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications
  
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :street_address
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zip_code
  validates_presence_of :description
  validates_presence_of :status

  def self.find_associated_pets
    @pets = Application.all.first.pets
  end
end
