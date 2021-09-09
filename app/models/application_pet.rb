class ApplicationPet < ApplicationRecord
  belongs_to :application
  belongs_to :pet

  def self.find_by_ids(pet_id, app_id)
    where(pet_id: pet_id, application_id: app_id).first
  end
end
