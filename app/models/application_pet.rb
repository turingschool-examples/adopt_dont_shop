class ApplicationPet < ApplicationRecord
  belongs_to :application
  belongs_to :pet

  enum pet_status:["Pending", "Accepted", "Rejected"]

  def self.find_application_pet(pet_id, app_id)
    where(application_id: app_id, pet_id: pet_id).first
  end
end