class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :pet_applications
  has_many :applications, through: :pet_applications
  
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  
  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end
end
