class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :street_address
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zip_code
  validates_presence_of :status

  def self.find_desired_pets(pet_name)
    Pet.where(name: pet_name)
  end

  def self.find_desired_application(desired_id)
    where(id: desired_id)
  end

end
