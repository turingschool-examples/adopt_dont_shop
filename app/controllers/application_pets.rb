class ApplicationPets < ApplicationController

  def create
    @application = Application.find(params[:id])
    # @application.pets << Pet.find(params[:add_pet])
    ApplicationPet.create!(application_id: params[:id], pet_id: params[:add_pet], status: "Pending")
    redirect_to "/applications/#{@application.id}"
  end

end
