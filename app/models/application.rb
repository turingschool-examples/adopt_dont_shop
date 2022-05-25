class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pet, through: :pet_applications
  validates_presence_of :name
  validates_presence_of :street_address
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zipcode
  validates_presence_of :status

  # enum :status, [:in_progress, :pending, :approved, :rejected]

  def status_pending
    update(status: "Pending")
  end

  def status_update
    new_status = pet_applications.pluck(:status)
    if new_status.include?("Approved")
      update(status: "Approved")
    elsif new_status.include?("Rejected")
      update(status: "Rejected")
    end
  end
end
