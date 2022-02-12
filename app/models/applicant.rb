class Applicant < ApplicationRecord
  validates :name, presence: true
  validates_uniqueness_of :name

  has_many :pet_applicants
  has_many :pets, through: :pet_applicants

  before_create do
    self.status = "In Progress"
  end

end
