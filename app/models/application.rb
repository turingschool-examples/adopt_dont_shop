# frozen_string_literal: true

class Application < ApplicationRecord
  validates_presence_of :name, :street_address, :city, :state, :zip_code
  has_many :pet_applications
  has_many :pets, through: :pet_applications
  has_many :shelters, through: :pets

  def find_app_approved(pet_id)
    app = Application.joins(:pets).where(pets: { id: pet_id }).pluck(:status)
    app.include?('Approved')
  end

  def status_update
    if approved
      update!(status: 'Approved')
      adopt_pets
    elsif rejected
      update!(status: 'Rejected')
    end
  end

  def check_status
    pet_applications.select(:status)
  end

  def approved
    check_status.to_a.count == check_status.where(status: 'true').count
  end

  def rejected
    check_status.where(status: 'false').count >= 1 && check_status.where(status: nil).count.zero?
  end

  def adopt_pets
    pets.update_all(adoptable: false)
  end
end
