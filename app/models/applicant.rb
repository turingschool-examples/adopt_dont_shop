class Applicant < ApplicationRecord
  validates :full_name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zipcode, presence: true, numericality: true

  has_many :applicants_pets, dependent: :destroy
  has_many :pets, through: :applicants_pets, dependent: :destroy

end
