class AdoptAppsController < ApplicationController
  def show
    @adopt_app = AdoptApp.find(params[:id])
    @pets = @adopt_app.pets
  end

  def create
    app = AdoptApp.create(app_params)
    redirect_to "/adopt_apps/#{app.id}"
  end

  private 
  def app_params
    params.permit(:id, :name, :street_address, :city, :state, :zip_code)
  end


end
