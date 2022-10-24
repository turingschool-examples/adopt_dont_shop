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

  def self.search_by_approval_status(parameter)
    joins("INNER JOIN pet_applications ON pet_applications.pet_id = pets.id").joins("INNER JOIN applications ON pet_applications.application_id = applications.id").where("approved ?", false)
  end
end
