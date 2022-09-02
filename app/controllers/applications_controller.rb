class ApplicationsController < ApplicationController
 
  def show
    require 'pry' ; binding.pry
    @application = Application.find(params[:id])
    @pets = Application.find_associated_pets
  end

  def new
  end

  def create
    @application = Application.new(application_params)
    @application[:status] = "In Progress"
    if @application.save
      redirect_to "/applications/#{@application.id}"  
    else
      redirect_to "/applications/new"
      flash[:alert] = "Error: You must fill in the missing information before proceeding."
    end
  end

  private
  def application_params
    params.permit(:first_name, :last_name, :street_address, :city, :state, :zip_code, :description, :status)
  end

end
