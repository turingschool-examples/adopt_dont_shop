class PetPetition < ApplicationRecord
  belongs_to :pet
  belongs_to :petition

  def self.associated_pets(id)
    pet_ids = where("petition_id = ?", id).pluck(:pet_id)
    Pet.find(pet_ids)
  end
end
