class Application < ApplicationRecord
  has_many :application_pets, dependent: :destroy
  has_many :pets, through: :application_pets
  validates_presence_of :name, :address, :city, :state, :zip

end
