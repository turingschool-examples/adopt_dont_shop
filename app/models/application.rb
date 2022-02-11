class Application < ApplicationRecord
  validates :name, presence:true
  validates :address, presence:true
  validates :description, presence:true
  validates :pet_names, presence:true
  validates :status, presence:true

  has_many :pet_applications
  has_many :pets, through: :pet_applications
end
