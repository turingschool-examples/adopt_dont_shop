class Application < ApplicationRecord
  has_many :pet_applications, :dependent => :destroy
  has_many :pets, through: :pet_aplications
  validates :name, :address, :city, :state, :zip_code, presence: true
end
