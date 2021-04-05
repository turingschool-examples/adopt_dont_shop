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
    where(accepted: true)
  end

  def self.in_progress
    where(in_progress: true)
  end

  def self.rejected
    where(rejected: true)
  end

  def self.pending
    where(pending: true)
  end
end
