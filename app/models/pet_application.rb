class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  validates :application_id, presence: true
  validates :pet_id, presence: true

  enum status: ["In Progress", "Approved", "Rejected"]

  def self.status(id)
    self.select(:status).where(application_id: id).first.status
  end
end