class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets
  validates :name, :street_address, :city, :state, :zipcode, presence: true
  
  def change_status
    self.status = 'Pending'
  end

  def any_pets? 
    pets.count > 0
  end
end