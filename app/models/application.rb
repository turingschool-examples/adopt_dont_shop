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
    if ApplicationPet.rejected_pet_count_for_app(self.id) > 0
      self.update!(status: 'Rejected')
    elsif ApplicationPet.approved_pet_count_for_app(self.id) == self.pets.count
      self.update!(status: 'Approved')
    end
  end
end