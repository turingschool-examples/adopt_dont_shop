class PetitionPet < ApplicationRecord
  belongs_to :petition
  belongs_to :pet

  def add_pet(petition, pet)

  end
end