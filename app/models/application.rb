class Application < ApplicationRecord
  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true, numericality: true
  has_many :application_pets
  has_many :pets, through: :application_pets

  def full_address
    self.street_address + ', ' + self.city + ', ' + self.state + ' ' + self.zip_code.to_s
  end
end