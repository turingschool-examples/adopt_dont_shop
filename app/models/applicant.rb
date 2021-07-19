class Applicant < ApplicationRecord
  has_many :pet_apps, dependent: :destroy
  has_many :pets, through: :pet_apps

  enum status: { in_progress: 0, pending: 1, approved: 2, rejected: 3 }

  validates :name, presence: true
  validates :street, presence: true
  validates :zip, presence: true, numericality: true
  validates :city, presence: true
  validates :state, presence: true
end