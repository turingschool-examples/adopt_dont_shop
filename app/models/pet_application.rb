class PetApplication < ApplicationRecord
  validates :name, presence: true
  validates :street, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true
  has_many :pets_pet_apps
  has_many :pets, through: :pets_pet_apps

end
