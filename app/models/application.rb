class Application < ApplicationRecord
    has_many :application_pets
    has_many :pets, through: :application_pets

    def get_pets(app_id)
        Pet.joins(:application_pets).where("application_pets.application_id = ?", app_id)
    end 
end