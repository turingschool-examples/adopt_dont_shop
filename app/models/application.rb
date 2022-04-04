class Application < ApplicationRecord
  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zipcode, presence: true


  has_many :application_pets
  has_many :pets, through: :application_pets

  def pets_added
    Pet.joins(applications: :application_pets).where("applications.id=#{self.id}")
  end


  def application_pet_status(pet_id)
    application_pet = ApplicationPet.where(application_id: id, pet_id: pet_id).first
    if application_pet.updated?
      application_pet.status 
    end
  end

end
