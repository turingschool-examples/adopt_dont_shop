class ApplicationPet < ApplicationRecord
  belongs_to :application
  belongs_to :pet
  validates_presence_of :application_id, 
                       :pet_id
                      
  def self.all_approved?
    all.all? { |application_pet| application_pet.status == "Approved" }
  end
end
