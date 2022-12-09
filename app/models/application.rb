class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets
  attribute :status, :string, default: 'In Progress'

  def full_address 
    "#{street_address}, #{city}, #{state} #{zip_code}"
  end
end