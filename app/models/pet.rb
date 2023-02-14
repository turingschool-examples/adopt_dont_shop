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


  # def self.search(pet_name)
  #   if pet_name 
  #     pet = Pet.find_by(name: pet_name)
  #     if pet 
  #       self.where(name: pet)
  #     else
  #       Pet.all
  #     end
  #   else 
  #     Pet.all
  #   end
  #   # where("name ILIKE ", "%#{pet_name}%")
  # end
end
