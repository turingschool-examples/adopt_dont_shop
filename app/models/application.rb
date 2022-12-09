class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets
  validates :name, :street_address, :city, :state, :zip_code, presence: true
  validates :zip_code, length: { is: 5 }
  validates :zip_code, :numericality => { :greater_than_or_equal_to => 0}
end