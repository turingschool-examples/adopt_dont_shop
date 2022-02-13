class PetApplication < ApplicationRecord
    enum status: {"Accepted": 0, "Rejected": 1}
    belongs_to :application
    belongs_to :pet

    def self.find_joins_row(application, pet)
        a_pet_id = pet.id
        app_id = application.id
        where(pet_id: a_pet_id, application_id: app_id)  
    end 
end 