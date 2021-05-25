class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets

  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true

  def self.filter_by_pending
    where(status: 'Pending').pluck(:id)
  end

  def evaluate_status
    if application_pets.where(status: 'Rejected').count > 0
      update!(status: 'Rejected')
    elsif application_pets.where(status: 'Approved').count == self.pets.count
      update!(status: 'Approved')
      pets.update_all(adoptable: false)
    end
  end
end