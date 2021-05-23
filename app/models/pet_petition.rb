class PetPetition < ApplicationRecord
  belongs_to :pet
  belongs_to :petition
end
