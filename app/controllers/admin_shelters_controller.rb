class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.reverse_alpha
    pending_applications = Application.pending_apps
    
    # # application_pets = []
    # # pending_applications.each do |application.pets|
    # #   application_pets << ApplicationPet.where(application_id: application.id)
    # end
    # pets = []
    # application_pets.flatten.each do |app_pet|
    #   pets << Pet.where(id: app_pet.pet_id)
    # end
    # shelters = []
    # pets.flatten.each do |pet|
    #   shelters << Shelter.where(id: pet.shelter_id)
    # end
    # @shelters_pending = shelters.flatten
  end
end