class Application < ApplicationRecord
  after_initialize :set_defaults

  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zipcode, presence: true
  # validates :description, presence: true
  # validates :status, presence: true

  has_many :pet_applications
  has_many :pets, through: :pet_applications

  def set_defaults
    self.description ||= ""
    self.status ||= "In Progress"
  end
end
