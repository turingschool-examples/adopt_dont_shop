class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  has_many :applicant_pets
  belongs_to :shelter
  has_many :applicants, through: :applicant_pets

  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end
end
