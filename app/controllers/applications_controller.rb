class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:application_id])
    @pets = @application.pets
  end

  def new

  end

  def create
    # require 'pry'; binding.pry
    if app_params[:name] == ""
      redirect_to "/applications/new", notice: "You must fill in all fields"
    else
      @application = Application.create(app_params)
      redirect_to "/applications/#{@application.id}"
    end
  end

private 
  def app_params
    params.permit(:name, :street, :city, :zip, :state, :applicant_argument, :app_status)
  end
end