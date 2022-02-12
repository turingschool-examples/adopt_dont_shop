class Applicant < ApplicationRecord
  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zipcode, presence: true
  validates_uniqueness_of :name

  has_many :pet_applicants
  has_many :pets, through: :pet_applicants

  before_create do
    self.status = "In Progress"
  end

end
