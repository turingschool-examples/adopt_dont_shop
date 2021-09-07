class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets

  validates_presence_of :name, :address, :status
end
