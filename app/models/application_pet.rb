class ApplicationPet < ApplicationRecord
  belongs_to :application
  belongs_to :pet
  validates_presence_of :application_id, 
                       :pet_id
                      
end
