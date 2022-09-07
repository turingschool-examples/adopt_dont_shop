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

  def self.application_status_pet_name(var)
    select("pet_applications.*", "pets.name")
    .joins(:pet_applications)
    .where("pet_applications.application_id = ?", var)
  end
end
