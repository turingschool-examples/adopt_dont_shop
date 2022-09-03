class PetApplication < ApplicationRecord
  belongs_to :application
  belongs_to :pet

  def self.pending_pets
    Pet.joins(:applications).where("applications.status = ?", "Pending")
  end

end
