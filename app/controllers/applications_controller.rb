class ApplicationsController < ApplicationController

  def index
  end

  def show
   @app = Application.find(params[:id])
   @pets = @app.list_pets
  end

  def new

  end

  def create
    application = Application.new(application_params)
    # require 'pry' ; binding.pry
    if application.save
      redirect_to "/applications/#{application.id}"
    else
    flash[:notice] = "Please fill out the whole form"
    render :new
    end
  end

  def application_params
    params.permit(:id, :name, :address, :city, :state, :zipcode, :about, :status)
  end


end
