class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  validates :name, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zipcode, presence: true
  validates :status, presence: true

  attribute :description, :string, default: ' '
  attribute :status, :string, default: 'In Progress'

  def update_status_pending
    update({ status: 'Pending' })
  end
end
