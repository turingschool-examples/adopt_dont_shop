class Application < ApplicationRecord
  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zipcode, presence: true


  has_many :application_pets
  has_many :pets, through: :application_pets

  def pets_added
    Pet.joins(:applications).where("applications.id=#{self.id}")
  end


  def application_pet_status(pet_id)
    application_pet = application_pets.where(pet_id: pet_id).first
    if application_pet.updated?
      application_pet.status 
    else 
      nil
    end
  end

  def all_pets_reviewed?
    application_pet_tot = application_pets
    application_pet_reviewed = application_pets.where("status IS NOT NULL")
    application_pet_reviewed.count == application_pet_tot.count
  end


 def all_pets_approved?
    application_pet_tot = application_pets
    application_pet_approved = application_pets.where(status: 'approved')
    application_pet_approved.count == application_pet_tot.count
  end

  def approve_application
    self.status = 'Approved'
    self.save
  end

  def reject_application
    self.status = 'Rejected'
    self.save
  end
end
