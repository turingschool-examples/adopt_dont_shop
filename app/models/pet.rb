class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  belongs_to :shelter
  has_many :application_pets
  has_many :applications, through: :application_pets

  def shelter_name
    shelter.name
  end

  def application_status(app_id)
    @application_pet = ApplicationPet.where(pet_id: id, application_id: app_id).first
    @application_pet.pet_status
  end

  def self.adoptable
    where(adoptable: true)
  end
end
