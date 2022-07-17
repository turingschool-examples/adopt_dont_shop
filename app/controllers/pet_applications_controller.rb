class PetApplicationsController < PetApplicationsController
   def create
    @pet_application = PetApplication.create!(pet_application_params)
    redirect_to "/applications/#{@pet_application.application_id}"
    @pet_application.save
  end
end