class AppsController < ApplicationController
  def show
    @app = App.find(params[:id])
    @results = search(params[:query])
    if !params[:pet_id].blank?
      @new_pet = Pet.find(params[:pet_id])
      @app.adopt(@new_pet)
    end
  end
end