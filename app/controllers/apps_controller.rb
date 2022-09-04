class AppsController < ApplicationController
  def index
    @apps = App.all
  end
  
  def show
    @app = App.find(params[:id])
    if params[:pet_id].present?
      @new_pet = Pet.find(params[:pet_id])
      @app.adopt(@new_pet)
    elsif params[:search].present?
      @pets = Pet.search(params[:search])
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