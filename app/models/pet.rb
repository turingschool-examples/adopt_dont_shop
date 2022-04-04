class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  belongs_to :shelter
  has_many :applications_pets
  has_many :applications, through: :applications_pets
  
  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end
end
