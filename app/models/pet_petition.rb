class PetPetition < ApplicationRecord
  belongs_to :pet
  belongs_to :petition

  def self.associated_pets(id)
    pet_ids = where('petition_id = ?', id).pluck(:pet_id)
    Pet.find(pet_ids)
  end

  def self.select(pet_id, petition_id)
    where("pet_id = ? AND petition_id = ?", pet_id, petition_id).first
  end
end
