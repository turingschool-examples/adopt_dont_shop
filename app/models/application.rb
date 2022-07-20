class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, -> { distinct }, through: :pet_applications

  attribute :app_status, default: "In-Progress"

  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zipcode, presence: true

  def pending_pet_applications?
    pet_applications.where(status: "Pending").any?
  end

  def any_rejected_pet_applications?
    pet_applications.where(status: "Rejected").any?
  end

  def all_accepted_pet_applications?
    pet_applications.where(status: "Approved").all?
  end

  def reject_application
    update!(app_status: "Rejected")
  end

  def approve_application
    update!(app_status: "Approved")
  end

  def pets_no_longer_adoptable
    pets.update_all(adoptable: false)
  end
end