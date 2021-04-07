class PetApplicationsController <ApplicationController
  def create
    application = Application.find(params[:id])
    pet = Pet.find(params[:pet])
    PetApplication.create(pet: pet, application: application)
    redirect_to "/applications/#{application.id}"
  end
end
