class Application < ApplicationRecord
  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true
  validates :description, presence: true
  validates :status, presence: true

  # has_many :pets, dependent: :destroy
  has_many :applications_pet
  has_many :pets, through: :applications_pet
end
