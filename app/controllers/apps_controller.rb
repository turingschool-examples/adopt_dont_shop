class AppsController < ApplicationController
  def show
    @app = App.find(params[:id])
    @results = search(params[:query])
    if !params[:pet_id].blank?
      @new_pet = Pet.find(params[:pet_id])
      @app.adopt(@new_pet)
    end
  end

  def new
  end

  def create
    @app = App.create!(app_params)

    redirect_to "/apps/#{@app.id}"
  end

  private
  def app_params
    params.permit(:name, :address, :city, :state, :zip_code, :description)
  end
end