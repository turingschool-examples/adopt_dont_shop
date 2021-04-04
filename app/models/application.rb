class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets

  validates :name, :street_address, :city, :zip_code, presence: true
  after_initialize :default, unless: :persisted? #unless status is changed, it will remain "in progress"

  def default
    self.status = "In Progress"
  end

  def status_change
    #once description and adopt this pet has 
    #been completed, status change
    #call for update to attribute status, for
    #now hardcode status into pending
  end
end
