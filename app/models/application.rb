class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  def self.find_associated_pets
    @pets = Application.all.first.pets
  end
end
