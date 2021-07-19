class Applicant < ApplicationRecord
  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true
  has_many :pet_applicants
  has_many :pets, through: :pet_applicants

  def associated_pets(applicant_id)
    PetApplicant.where('applicant_id = ?', applicant_id).map do |join|
      Pet.find(join.pet_id)
    end
  end
end
