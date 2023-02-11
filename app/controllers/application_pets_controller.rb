class ApplicationPetsController < ApplicationController

  def create
    @application = Application.find(params[:id])
    @application.add_pet(Pet.find(params[:pet_id]))
    @has_pets = @application.has_pets?
    redirect_to "/applications/#{@application.id}"
  end
  
end