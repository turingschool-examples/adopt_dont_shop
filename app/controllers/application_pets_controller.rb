class ApplicationPetsController < ApplicationController

  def create
    @application = Application.find(params[:id])
    @pet = Pet.find(params[:pet_id])
    @pet_app = ApplicationPet.create!(application: @application, pet: @pet)
    redirect_to "/applications/#{@application.id}"
  end


  def update #model test?
    @pet_app = ApplicationPet.find(params[:id])
    if params[:status] == "Approved"
      @pet_app.update!(:status => "Approved")
    else
      @pet_app.update!(:status => "Rejected")
    end
    redirect_to "/admin/applications/#{@pet_app.application_id}"
  end

  def application_pet_params
    params.permit(:application_id, :pet_id, :status)
  end
end
