class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets

  validates :first, presence: true
  validates :last, presence: true
  validates :street, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true
  validates :description, presence: true
  validates :status, presence: true

  def self.applications_by_shelter
    self.find_by(status: "Pending").pets.map {|pet| pet.shelter}
  end
end