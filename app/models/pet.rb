class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  belongs_to :shelter
  has_many :pet_applicants
  has_many :applicants, through: :pet_applicants

  def self.adoptable
    where(adoptable: true)
  end

  def self.search(search)
    where("name ILIKE ?", "%#{search}%")
  end

  def shelter_name
    shelter.name
  end
end
