class ApplicationsController < ApplicationController

  def show
    @pets = Application.find_desired_pets(params["desired_pet"])
    @application = Application.find(params[:id])
    if params[:commit] == "Search for Pet"
    @pets = Application.find_desired_pets(params["desired_pet"])
    end
  end

  def new
  end

  def update
    @application = Application.find(params[:id])
    if params[:adding_description] == "update_description"
      @application.description = params[:description]
      @application.status = "Pending"
      @application.save

      redirect_to "/applications/#{@application.id}"
    end
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
    params.permit(:first_name, :last_name, :street_address, :city, :state, :zip_code, :status)
  end

end
