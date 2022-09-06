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
    joins(:applications, :shelter).select('shelters.*').where("applications.status = ?", "Pending").distinct.order("shelters.name")
  end

  def self.avg_age
    adoptable.average(:age).round(1)
  end

  def self.count_adoptable
    adoptable.count
  end

  def self.adopted_pet_count
    where(adoptable: false).count
  end

  def self.pet_app_pending(shelter_id)
    Pet.select("pets.name as pet_name", "pets.shelter_id as shelter_id", "pet_applications.pet_status as pet_status", "applications.id as application_id", "applications.status as application_status").joins(:applications).where("applications.status = ?", "Pending").where("shelter_id = ?", shelter_id)
  end
end
