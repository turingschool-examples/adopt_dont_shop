class Application < ApplicationRecord
  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true, numericality: true

  has_many :pet_applications
  has_many :pets, through: :pet_applications

  def status_check
    pet_app_statuses = self.pet_applications.pluck(:status)

    if pet_app_statuses.empty?
      "In Progress"
    elsif pet_app_statuses.any?(nil)
      "Pending"
    elsif pet_app_statuses.all?("Approved")
      "Approved"
    elsif pet_app_statuses.any?("Rejected")
      "Rejected"
    end
  end
end
