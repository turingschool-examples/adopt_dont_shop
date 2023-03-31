class AppsController < ApplicationController

  def index
    @apps = App.all 
  end

  def show
    @app = App.find(params[:id])
    @pets = @app.pets
  end
  
  def new
  end

  def create
    app = App.new(app_params)

    if app.save
      app.status = "In Progress"
      redirect_to "/apps/#{app_params[:app_id]}"
    else 
      redirect_to "/apps/new"
      flash[:alert] = "Error: #{error_message(app.errors)}"
    end
  end


  private
  def app_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description)
  end
end