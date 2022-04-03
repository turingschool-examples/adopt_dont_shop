class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  belongs_to :shelter
  has_many :pet_applications
  has_many :applications, through: :pet_applications

  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end

  def self.search(search)
    if search
      pet_name = Pet.find_by(name: search)
        if pet_name
          self.where(name: pet_name)
        else
          @pets = Pet.adoptable
        end
    else
      @pets = Pet.adoptable 
    end
  end
end
