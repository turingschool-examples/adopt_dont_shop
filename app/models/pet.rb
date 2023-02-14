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

  def approved?(app_id)
    status = application_pets.where(application_id: app_id).pluck(:pet_status).first
    status == "Accepted"
  end 

  def rejected?(app_id)
    status = application_pets.where(application_id: app_id).pluck(:pet_status).first
    status == "Rejected"
  end
end
