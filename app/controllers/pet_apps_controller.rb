class PetAppsController < ApplicationController

  def create
    @app = App.find(params[:id])
    @pet = Pet.find(params[:pet])
    PetApp.create!(app: @app, pet: @pet)
    redirect_to "/apps/#{@app.id}"
  end
end