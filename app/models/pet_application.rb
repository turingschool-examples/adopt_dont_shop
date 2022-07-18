class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  def self.find_pet_app(pet_id, app_id)
    where(application_id: app_id, pet_id: pet_id)[0]
  end 

  def self.pet_app_count(app_id)
    where(application_id: app_id).count
  end 

  def self.pet_app_approved_count(app_id)
    where("application_id = ? AND app_status = ?", app_id, "Approved").count
  end 

  def self.pet_app_rejected_count(app_id)
    where("application_id = ? AND app_status = ?", app_id, "Rejected").count
  end 
end