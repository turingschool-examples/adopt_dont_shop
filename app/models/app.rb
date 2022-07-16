class App < ApplicationRecord
  validates :name, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true
  validates :status, inclusion: ["in progress", "pending", "accepted", "rejected"]
  has_many :pet_apps
  has_many :pets, through: :pet_apps
end
