class ApplicationsController < ApplicationController
  def show
    # find the application
    @application = Application.find(params[:id])

    # find all ApplicationPet instances for this application
    @application_pets = ApplicationPet.where(application_id: params[:id])
    # refactor into model ^^

    # find an array of just the pet_id numbers on this application
    pet_ids = @application_pets.pluck(:pet_id) 

    # find all pets that match the above pet_id's array
    @pets = Pet.where(id: pet_ids) 

    # and finally, the lol simple solution that skips the prior 3 steps using the 'through' association
    @pets = @application.pets 
  end
end