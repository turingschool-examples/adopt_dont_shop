class Application < ApplicationRecord
  validates :name, presence:true
  validates :street_address, presence:true
  validates :city, presence:true
  validates :state, presence:true
  validates :zip, presence:true
  validates :description, presence:true
  validates :status, presence:true

  has_many :applicationpets
  has_many :pets, through: :applicationpets

end