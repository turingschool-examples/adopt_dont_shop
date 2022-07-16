class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  belongs_to :shelter
  has_many :applicant_pets
  has_many :applicants, through: :applicant_pets

  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end

  def self.pet_search(pet_name)
      find_by(name: pet_name)
  end
end
