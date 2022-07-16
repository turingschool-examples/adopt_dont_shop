class Applicant < ApplicationRecord
  has_many :applicant_pets
  has_many :pets, :through => :applicant_pets
end