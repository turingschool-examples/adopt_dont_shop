class ApplicationPet < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  def self.find_application_pet(app_id, pet_id)
    ApplicationPet.where(application_id: app_id, pet_id: pet_id).first
  end
end