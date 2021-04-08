class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  belongs_to :shelter
  has_many :pet_owner_applications
  has_many :owner_applications, through: :pet_owner_applications

  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end

  def self.search(search)
    if search
      pet = Pet.find_by(name: search)
    end
  end
end
