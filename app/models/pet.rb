class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  belongs_to :shelter
  has_many :applications_pets
  has_many :applications, through: :applications_pets
  
  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end

  def self.search_by_name(name)
    where('lower(name) LIKE ?', "%#{name.downcase}%").all
  end
end
