class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  validates_presence_of :name, :street, :city, :state, :zip, :description,
   :application_status

  def self.show_pets 
    Pet.all
  end
end
