class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets
  enum status: [:in_progress, :pending, :accepted, :rejected]
  validates_presence_of :name
  validates_presence_of :address
  # validates_presence_of :description
  # validates_presence_of :pet_names
  validates_presence_of :status

  def self.pending_apps
    joins(:pets).where(status: '1')
  end
end
