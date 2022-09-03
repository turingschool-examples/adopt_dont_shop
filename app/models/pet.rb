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

  def self.add_pet_status(params)
    #select all columns from pets table and combine with pet_status and application id columns from pet_applications table. 
    #theoretically, where will limit to just the pets that are associatied with this one application via the app_id column
    # `vars = select('pets.*, pet_applications.pet_status, pet_applications.application_id as app_id').joins(:pet_applications).distinct
    # require 'pry'; binding.pry
    select('pets.*, pet_applications.pet_status, pet_applications.application_id as app_id').joins(:pet_applications).distinct
  end
end
