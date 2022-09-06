class PetApplication < ApplicationRecord
  belongs_to :application
  belongs_to :pet

  def self.pending_pets
    Pet.joins(:applications).where("applications.status = ?", "Pending")
  end

  def self.application_pets
    Pet.select("pets.*, pet_applications.*").joins(:pet_applications).where
  end
end
