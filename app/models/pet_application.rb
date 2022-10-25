class PetApplication < ApplicationRecord 
  belongs_to :application
  belongs_to :pet

  def self.based_on_conditions(reject, approve, application)
    where("rejected = ? AND approved = ? AND application_id = ?", reject, approve, application)
  end

  def self.based_on_ids(pet, application)
    where("pet_id = ? AND application_id = ?", pet, application)
  end
end

