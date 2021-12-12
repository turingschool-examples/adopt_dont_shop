class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets
  after_initialize :set_defaults, unless: :persisted?
  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true
  # added to allow a default entry for all new rows created.
  def set_defaults
    self.status ||= "In Progress"
  end
end
