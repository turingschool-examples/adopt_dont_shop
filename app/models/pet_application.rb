class PetApplication < ApplicationRecord 
  belongs_to :application
  belongs_to :pet

  def self.pets_based_on_application(reject, approve, application)
    where("rejected = ? AND approved = ? AND application_id = ?", reject, approve, application)
  end
end

