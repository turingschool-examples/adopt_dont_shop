class Pet < ApplicationRecord
  validates :name,   presence: true
  validates :age,   presence: true,   numericality: true
  belongs_to :shelter
  has_many :pet_applications
  has_many :applications,   through: :pet_applications

  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(    adoptable: true)
  end

  def self.search(search_params)
    pet = Pet.find_by(    name: search)

    if pet
      @pets = Pet.where("name ILIKE ?", "%#{search_params}%")
    end
  end
end
