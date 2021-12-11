class Pet < ApplicationRecord
  has_many :application_pets
  has_many :applications, through: :application_pets
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  belongs_to :shelter

  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end
end
