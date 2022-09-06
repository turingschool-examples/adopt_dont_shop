class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets
  after_initialize :set_defaults

  def list_pets
    self.pets.where("application_pets.application_id = ?", self.id)
  end

  private
  def set_defaults
    self.status ||= 'In Progress'
    self.about ||= 'Fill out after adding pets please.'
  end
end
