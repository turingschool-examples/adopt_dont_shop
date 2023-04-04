class Application < ApplicationRecord
  validates :name, :address, :city, :state, :zip, :description, presence: true
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  enum status: {"In Progress": 0, "Pending": 1, "Accepted": 2, "Rejected": 3}

  def has_pending_pets?
    PetApplication.where(approved: nil, application_id: self.id).present?
  end

  def has_rejected_pets?
    PetApplication.where(approved: false, application_id: self.id).present?
  end
end