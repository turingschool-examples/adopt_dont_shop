class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets
  after_initialize :set_defaults, unless: :persisted?

  def set_defaults
    self.status ||= "In Progress"
  end
end
