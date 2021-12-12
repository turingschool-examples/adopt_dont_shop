class ApplicationPetsController < ApplicationController

  def index
  end

  def new
    @application_id = params[:application_id]
  end



  def create
    @application_id = params[:application_id]
    pet = Pet.create(pet_params)
    redirect_to "/applications/#{application_id}/pets"
  end


  private

  def pet_params
    params.permit(:id, :name, :age, :breed, :adoptable, :shelter_id)
  end

end
