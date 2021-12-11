class Application < ApplicationRecord
  store_accessor :address, :city
  store_accessor :address, :state
  store_accessor :address, :zip
  store_accessor :address, :street
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true
  validates :street, presence: true
  validates :name, presence: true
  validates :description, presence: true
  has_many :addresses
  has_many :application_pets
  has_many :pets, through: :application_pets
end
