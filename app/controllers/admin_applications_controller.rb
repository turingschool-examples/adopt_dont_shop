class AdminApplicationsController < ApplicationController

  def show
    @app = Application.find(params[:id])
    @pets = @app.pets
    # require "pry"; binding.pry

     if params[:pet_app_id] != nil
       @pet_app = PetApplication.find(params[:pet_app_id])
     else
       @pet_app = []
     end
  end

end
