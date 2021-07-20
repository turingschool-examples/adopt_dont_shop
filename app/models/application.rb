class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications
  validates :name, :street, :city, :state, :description, presence: true
  validates :zip_code, presence: true, numericality: { only_integer: true }
  validates_length_of :zip_code, is: 5,  message: "number must be 5 digits long"
end
