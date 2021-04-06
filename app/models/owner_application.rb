class OwnerApplication < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications
  # validates :name, presence: true,
  # :street_address, presence: true,
  # :city, presence: true,
  # :state, presence: true,
  # :zip_code, presence: true
end
