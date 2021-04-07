class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  has_many :applications, through: :pet_applications
  belongs_to :shelter

  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end
end
