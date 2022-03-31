class Application < ApplicationRecord
  validates :name, presence: true
  validates :full_address, presence: true
  validates :description, presence: true
 
  has_many :application_pets
  has_many :pets, through: :application_pets

end
