class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  belongs_to :shelter
  has_many :applications_pet
  has_many :applications, through: :applications_pet

  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end
end
