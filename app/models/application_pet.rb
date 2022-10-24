class ApplicationPet < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  def self.find_application_pet(pet_id, application_id)
    @application_pet = ApplicationPet.find_by(pet_id: pet_id, application_id: application_id)
  end
end
