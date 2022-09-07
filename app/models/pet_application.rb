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
    pets_app_search(app_id).pets_status("Adoption Rejected").count
  end

  def application_complete?(app_id)
    PetApplication.pet_count(app_id) == PetApplication.pets_app_rej_count(app_id)
  end

  def complete_application(application)
    unless PetApplication.pets_rej_count(application.id).zero?
      application.update(status: "Rejected")
    else
      application.update(status: "Accepted")
      application.pets.each  do |pet|
        pet.update(adoptable: false)
      end
    end
  end
end