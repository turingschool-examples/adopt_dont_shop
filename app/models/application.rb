class Application < ApplicationRecord
  has_many :pet_applications, :dependent => :destroy
  has_many :pets, through: :pet_aplications
  validates_presence_of :name, :address, :city, :state, :zip_code, :description, :status
end
