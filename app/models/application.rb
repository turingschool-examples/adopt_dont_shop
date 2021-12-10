class Application < ApplicationRecord
  after_initialize :set_defaults

  def set_defaults
    self.description ||= "I like turtles"
  end
  
  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true
  validates :description, presence: true
  validates :status, presence: true

  has_many :application_pets, dependent: :destroy
  has_many :pets, through: :application_pets
end