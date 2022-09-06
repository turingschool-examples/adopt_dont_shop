class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  belongs_to :shelter

  has_many :pet_applications
  has_many :applications, through: :pet_applications

  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end

  def app_approval?(pet_id, application_id)
    PetApplication.find_by(pet_id: pet_id, application: application_id).approved?
  end

  def app_rejected?(pet_id, application_id)
    PetApplication.find_by(pet_id: pet_id, application: application_id).rejected?
  end
end
