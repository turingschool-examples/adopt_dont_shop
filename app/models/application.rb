class Application < ApplicationRecord
  validates :name, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zipcode, presence: true

  has_many :application_pets, dependent: :destroy
  has_many :pets, through: :application_pets

  enum status: ['In Progress', 'Pending', 'Accepted', 'Rejectd']

  def submittable?
    not_submitted? && pets.length > 0
  end

  def not_submitted?
    status == 'In Progress'
  end

  def set_to_pending
    update_attribute(:status, 1)
  end
end
