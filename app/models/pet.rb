class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  belongs_to :shelter
  has_many :application_pets
  has_many :applications, through: :application_pets

  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end

  def pet_app_approved?(pet_id, application_id)
    ApplicationPet.find_by(pet_id: pet_id, application_id: application_id).pet_status == "Approved"
  end

  def pet_app_rejected?(pet_id, application_id)
    ApplicationPet.find_by(pet_id: pet_id, application_id: application_id).pet_status == "Rejected"
  end
end

