class Applicant < ApplicationRecord
  validates :name, presence: true
  validates :street, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true
  # validates :good_home, presence: true
  has_many :pet_applicants, dependent: :destroy
  has_many :pets, through: :pet_applicants
end