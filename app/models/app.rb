class App < ApplicationRecord
  validates :name, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true
  validates :description, presence: true
  has_many :pet_apps
  has_many :pets, through: :pet_apps


  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end
end
