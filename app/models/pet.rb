class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  belongs_to :shelter
  has_many :pet_applications
  has_many :applications, through: :pet_applications

  def shelter_name
    shelter.name
  end

  def app_status(app_id)
    pet_applications.where(application_id: app_id).first.status
  end

  def self.adoptable
    where(adoptable: true)
  end
end
