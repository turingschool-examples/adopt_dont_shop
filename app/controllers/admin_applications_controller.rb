class AdminApplicationsController < ApplicationController
  def show
    @app = Application.find(params[:id])
    @pet_apps = @app.pet_applications
  end

end 
