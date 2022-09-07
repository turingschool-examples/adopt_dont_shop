class PetApplication < ApplicationRecord
  belongs_to :application
  belongs_to :pet

  def self.pending_pets
    Pet.joins(:applications).where("applications.status = ?", "Pending")
  end

  def self.application_pets(application_id)
    Pet.select("pets.*, pet_applications.application_id, pet_applications.pet_application_status").joins(:pet_applications).where("application_id = ?", "#{application_id}")
  end

end
