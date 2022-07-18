class App < ApplicationRecord
  validates :name, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true
  validates :status, inclusion: ["in progress", "pending", "accepted", "rejected"]
  has_many :pet_apps
  has_many :pets, through: :pet_apps

  def any_rejected?
    pet_apps.any? { |petapp| petapp.approval == 'Rejected'}
  end

  def all_approved?
    pet_apps.all? { |petapp| petapp.approval == 'Approved' }
  end

  def make_pets_unadoptable
    pets.each { |pet| pet.not_adoptable }
  end

  def final_status
    if any_rejected?
      update(status: 'rejected')
    elsif all_approved?
      update(status: 'accepted')
      make_pets_unadoptable
    end
  end
end
