class Applicant < ApplicationRecord
  has_many :pet_applicants
  has_many :pets, through: :pet_applicants
end
