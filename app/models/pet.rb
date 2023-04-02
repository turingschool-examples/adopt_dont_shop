class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  belongs_to :shelter
  has_many :pet_applicants, dependent: :destroy
  has_many :applicants, through: :pet_applicants

  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end

 
end
