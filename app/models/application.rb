class Application < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :address
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zipcode
  validates_presence_of :about
  validates_presence_of :status
  after_initialize :set_defaults

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
