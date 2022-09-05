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
    select('pets.*, pet_applications.pet_status, pet_applications.application_id as app_id').joins(:pet_applications).distinct
  end

  def self.pending_apps
    joins(:applications, :shelter).select('shelters.*').where("applications.status = ?", "Pending").distinct
  end

  def self.avg_age
    adoptable.average(:age).round(1)
  end

  def self.count_adoptable
    adoptable.count
  end
end
