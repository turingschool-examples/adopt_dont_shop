class Application < ApplicationRecord
  after_initialize :set_defaults

  def set_defaults
    self.description ||= "No Description"
    self.status ||= "In Progress"
  end

  has_many :pet_applications
  has_many :pets, through: :pet_applications

  validates_presence_of :name
  validates_presence_of :address
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zipcode
  validates_presence_of :description
  validates_presence_of :status
end
