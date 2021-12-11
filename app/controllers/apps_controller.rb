class AppsController < ApplicationController
  
  def new
  end

  def create
    @app = App.create(app_params)
    redirect_to "/apps/#{@app.id}"
  end
  
  def show
    @app = App.find(params[:id])
    @pets = @app.pets
  end

  private 
  def app_params
    params.permit(:name, :address, :city, :state, :zip)    
  end
end 