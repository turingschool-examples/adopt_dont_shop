  class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application
  validates :pet_status, inclusion: [nil, "Adoption Approved", "Adoption Rejected"]

  def self.pet_count(app_id)
    where("application_id = ?", app_id).count
  end

  def self.pets_app_rej_count(app_id)
    where(application_id: app_id, pet_status: "Adoption Approved").count + where(application_id: app_id, pet_status: "Adoption Rejected").count
  end

  def self.pets_rej_count(app_id)
    where("pet_status = ?", "Adoption Rejected").distinct.count
  end
end