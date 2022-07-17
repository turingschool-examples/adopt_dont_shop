class Applicant < ApplicationRecord
  after_initialize :defaults

  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true

  has_many :applicant_pets
  has_many :pets, :through => :applicant_pets

  def defaults 
    self.description ||= 'N/A'
    self.application_status ||= 'In Progress'
  end
end