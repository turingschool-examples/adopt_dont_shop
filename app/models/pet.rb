class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  belongs_to :shelter
  has_many :pets_applications
  has_many :applications, through: :pets_applications
  
  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end
end
