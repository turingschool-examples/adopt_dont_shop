class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :pet_applications, dependent: :destroy 
  has_many :applications, through: :pet_applications

  validates :name, presence: true
  validates :age, presence: true, numericality: true

  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end

  # def self.accept(application, pet)
  #   app = where(pet_id: pet).where(application_id: application)
  #   # app.update(approved: true, application_status: "Approved")
  # end
end
#   return application id from pet_application
