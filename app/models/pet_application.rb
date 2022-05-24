class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  def pet_name
    pet.name
  end
end
