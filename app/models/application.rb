class Application < ApplicationRecord
  validates_presence_of :applicant_name, :app_street, :app_city, :app_state, :app_zip_code
  has_many :application_pets
  has_many :pets, through: :application_pets

  enum status: ["In Progress", "Pending", "Accepted", "Rejected"]


  def add_pet(pet)
    self.pets << pet
  end

  def has_pets?
    if self.pets.count > 0
      true
    else
      false
    end
  end
end