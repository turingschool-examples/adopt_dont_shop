class Application < ApplicationRecord
  has_many :pet_applications 
  has_many :pets, through: :pet_applications 
  accepts_nested_attributes_for :pets 
  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true
  # validates :description, presence: true
  validates_presence_of :description, on: :update 
end