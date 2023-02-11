class PetitionPet < ApplicationRecord
  belongs_to :petition
  belongs_to :pet
end