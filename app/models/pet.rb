class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  belongs_to :shelter
  has_many :application_pets
  has_many :applications, through: :application_pets

  def shelter_name
    shelter.name
  end

  def app_stat(app_id, pet_id)
    ApplicationPet.where(application_id: app_id, pet_id: pet_id).pluck(:status)[0]
  end 

  def self.adoptable
    where(adoptable: true)
  end
end
