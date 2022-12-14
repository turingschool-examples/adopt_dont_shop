class ApplicationPet < ApplicationRecord
  belongs_to :application 
  belongs_to :pet
  
  def self.find_app(application_id, pet_id)
    where(application_id: application_id, pet_id: pet_id)
  end
end