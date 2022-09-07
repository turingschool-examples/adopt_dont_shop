class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets
  validates :first_name, :last_name, :str_address, :city, :state, presence: true
  validates :zip, numericality: true, length: { is: 5 }
end

