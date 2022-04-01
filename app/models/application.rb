class Application < ApplicationRecord
  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zipcode, presence: true


  has_many :application_pets
  has_many :pets, through: :application_pets

end
