class Application < ApplicationRecord
    has_many :application_pets
    has_many :pets, through: :application_pets

    def get_pets(app_id)
        Pet.joins(:application_pets).where("application_pets.application_id = ?", app_id)
    end 

    def application_info(app_id)
        app_info = {}
        app_info[:app] = Application.find(app_id)
        app_info
    end 

    def show_pets(app_id, name)
        app_info = {}
        app_info[:app] = Application.find(app_id)
        app_info[:pets] = Pet.where("lower(pets.name) like ?", "%#{name.downcase}%")
        app_info
    end 
end