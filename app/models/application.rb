class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets

  def full_address
    self.street_address + ', ' + self.city + ', ' + self.state + ' ' + self.zip_code.to_s
  end
end