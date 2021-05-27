class Application < ApplicationRecord
  has_many :application_pets, dependent: :destroy
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

  def self.pets_needing_action
    p = find_by_sql("Select b.id

      from applications a,
      application_pets b,
      pets c

      where a.id = b.application_id
      and b.pet_id = c.id
      and c.adoptable = true
      and a.status = 'Pending'
      and b.status IS NULL
      and c.id NOT IN (
      Select c.id

      from applications a,
      application_pets b,
      pets c,
      application_pets d

      where a.id = b.application_id
      and b.pet_id = c.id
      and a.id = d.application_id
      and c.adoptable = true
      and a.status = 'Pending'
      and b.status = 'Approved')
      ").pluck(:id)
  end
end