class PetApplicant < ApplicationRecord 
  enum status: ["In Progress", "Pending", "Accepted", "Rejected"]
  validates_presence_of :pet_id, :applicant_id, :status 
  belongs_to :pet 
  belongs_to :applicant 

  def self.find_pet_app(pet_id, app_id)
    find_by(pet_id: pet_id, applicant_id: app_id)
  end

  def approved 
    update_attribute(:status, 2)
  end

  def rejected 
    update_attribute(:status, 3)
  end
end