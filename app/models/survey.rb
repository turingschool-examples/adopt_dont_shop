class Survey < ApplicationRecord 
  after_initialize :set_defaults 

  def set_defaults 
    self.description ||= "No Description"
    self.status ||= "In Progress"
  end
  
  has_many :survey_pets 
  has_many :pets, through: :survey_pets

  validates_presence_of :name 
  validates_presence_of :street_address
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zip_code 
  validates_presence_of :description
  validates_presence_of :status
end