class ApplicationsController < ApplicationController
  def new
    # @application = Application.find(params[:id])
  end

  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
  end

  def create
    @application = Application.new(application_params)

    if @application.save  
      redirect_to "/applications/#{@application.id}"
    else
      redirect_to "/applications/new"
      flash[:alert] = "Error: All sections must be filled out"
    end
  end

private
  def application_params
    params.permit(:applicant_name, :street_address, :city, :state, :zip_code, :description)
  end
end