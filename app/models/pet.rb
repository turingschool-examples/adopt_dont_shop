class Pet < ApplicationRecord
  has_many :pet_apps, dependent: :destroy 
  has_many :applicants, through: :pet_apps
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  belongs_to :shelter

  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end
end
