class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets

  validates :name, :street_address, :city, :state, :reason_for_adoption, presence: true
  validates_numericality_of :zip_code

end