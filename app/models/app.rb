class App < ApplicationRecord
  has_many :pet_apps, dependent: :destroy
  has_many :pets, through: :pet_apps

  enum status: { "In Progress": 0, Pending: 1, Approved: 2, Rejected: 3 }

  validates :name, presence: true
  validates :street, presence: true
  validates :zip, presence: true, numericality: true
  validates :city, presence: true
  validates :state, presence: true
end