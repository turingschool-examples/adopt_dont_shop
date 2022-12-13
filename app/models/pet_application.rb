class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  def self.find_app(pet_id, app_id)
    self.where(pet_id: pet_id, application_id: app_id)
  end

  def find_by_pet_id(pet_id)
    where(pet_id: pet_id)
  end
end
