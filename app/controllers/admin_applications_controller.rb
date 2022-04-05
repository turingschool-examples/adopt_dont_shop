class AdminApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
    @app_pets = @application.application_pets
    # require "pry"; binding.pry
  end

  def update
    if params[:approve]
      @application = Application.find(params[:id])
      id = params[:pet_id].to_i

      @app_pet = @application.application_pets.where(pet_id: id)
      @app_pet.update(pet_status: 1)

      redirect_to "/admin/applications/#{@application.id}"
    elsif params[:deny]
      @application = Application.find(params[:id])
      id = params[:pet_id].to_i

      @app_pet = @application.application_pets.where(pet_id: id)
      @app_pet.update(pet_status: 2)

      redirect_to "/admin/applications/#{@application.id}"

    end
  end


end
