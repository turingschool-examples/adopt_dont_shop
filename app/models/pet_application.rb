  class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application
  validates :pet_status, inclusion: [nil, "Adoption Approved", "Adoption Rejected"]

  scope :pets_app_search, -> (app_id) {where(application_id: app_id)}
  scope :pets_status, -> (status = "Adoption Approved") {where(pet_status: status)}

  
  def self.pet_count(app_id)
    pets_app_search(app_id).count
  end

  def self.pets_app_rej_count(app_id)
    pets_app_search(app_id).pets_status.count + pets_app_search(app_id).pets_status("Adoption Rejected").count
  end

  def self.pets_rej_count(app_id)
    pets_status("Adoption Rejected").count
  end
end