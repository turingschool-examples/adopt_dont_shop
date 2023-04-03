class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  validates :adoptable, exclusion: [nil]
  validates :breed, presence: true

  belongs_to :shelter
  has_many :pet_applications
  has_many :applications, through: :pet_applications

  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end

  def self.search_adoptable_pets(search_pets)
    Pet.search(search_pets).where(adoptable: true)
  end
end
