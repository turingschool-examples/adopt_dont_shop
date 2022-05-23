class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  validates_presence_of :name, :street, :city, :state, :zip, :application_status

  def show_pets
    Pet.all.reject{ |pet| self.pets.ids.include?(pet.id) }
  end
end
