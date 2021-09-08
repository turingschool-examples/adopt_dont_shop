class AdminApplicationsController < ApplicationController

  def show
    @app = Application.find(params[:id])
    @pets = @app.pets
    # require "pry"; binding.pry


    @pet_app = PetApplication.find(params[:pet_app_id]) if params[:pet_app_id] != nil

  end

end
