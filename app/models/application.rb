class Application < ApplicationRecord
  validates :name, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true, numericality: true, length: { is: 5 }
  has_many :pet_applications, dependent: :delete_all
  has_many :pets, through: :pet_applications

  def in_progress?
   status == "In Progress"
  end

  def has_pets
    pets.count >= 1
  end

  def self.pending_applications
    joins(:pets).where(status: "Pending")
  end

  def pending?
    status == "Pending"
  end

  def update_status
    statuses = pet_applications.pluck(:application_status)
    if statuses.include?("Rejected")
      update(status: "Rejected")
    elsif statuses.all?("Approved")
      update(status: "Approved")
    else
      update(status: "Pending")
    end 
  end
end