class Application < ApplicationRecord
  has_many :application_pets, :dependent => :destroy
  has_many :pets, through: :application_pets

  validates_presence_of :name
  validates_presence_of :address
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zip
  validates_presence_of :description, on: :update
  validates_presence_of :status
end
