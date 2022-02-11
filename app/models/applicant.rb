class Applicant < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates_uniqueness_of :name
  validates_uniqueness_of :description

  has_many :pet_applicants
  has_many :pets, through: :pet_applicants
end
