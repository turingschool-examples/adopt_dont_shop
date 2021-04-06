class ApplicantsPet < ApplicationRecord
  validates :pet_id, presence: true, numericality: true
  validates :applicant_id, presence: true, numericality: true
  validates :description, presence: true

  belongs_to :pet
  belongs_to :applicant

  def pet_name
    pet.name
  end

  def applicant_name
    applicant.full_name
  end

  def self.accepted
    where(status: "Accepted")
  end

  def self.in_progress
    where(status: "In Progress")
  end

  def self.rejected
    where(status: "Rejected")
  end

  def self.pending
    where(status: "Pending")
  end
end
