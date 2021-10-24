class PetsApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  def add_pet(pet)
    application.pet_names << pet.name
  end
end
