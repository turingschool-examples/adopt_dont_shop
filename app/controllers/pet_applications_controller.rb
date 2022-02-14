class PetApplicationsController < ApplicationController
  def create
    @application = Application.find(params[:id])
    if params[:petid].present?
      @pet_application = PetApplication.create(pet_id: params[:petid], application_id: @application.id)
      @pets = @application.pets
      @add_pet = true
      redirect_to "/application/#{@application.id}"
    end
  end
end
