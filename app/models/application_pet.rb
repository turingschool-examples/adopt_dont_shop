class ApplicationPet < ApplicationRecord
  belongs_to :application
  belongs_to :pet
  
  def self.app_pet(application, pet_params)
    where("application_id = #{application.id} AND pet_id = #{pet_params}")
  end
end