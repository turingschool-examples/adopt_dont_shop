class Application < ApplicationRecord
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
    self.description ||= "I'm a qualified pet parent!"
    self.status ||= "Pending"
  end
end
