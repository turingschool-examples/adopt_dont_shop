class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
  end

  def application_params
    params.permit(:name, :address, :city, :state, :zip, :description)
  end

  def new
    @application = Application.new
  end

  def create
    @application = Application.new(application_params)
    if @application.save
      redirect_to "/applications/#{@application.id}"
    else
      flash[:alert] = "Please fill in all required fields."
      redirect_to "/applications/new"
    end
  end
  
end