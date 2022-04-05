class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets
  enum status: [:in_progress, :pending, :accepted, :rejected]
  validates_presence_of :name
  validates_presence_of :address
  # validates_presence_of :description
  # validates_presence_of :pet_names
  validates_presence_of :status


  def application_pet_status(pet_id)
    pet_app = application_pets.where(pet_id: pet_id, application_id: id).first
    pet_app.pet_status
  end

  def self.pending_apps
    joins(:pets).where(status: '1')
  end

  def all_pets_approved?

    if application_pets.where(pet_status: '1').count == application_pets.count
      true
    else
      false
    end
  
  end
end
