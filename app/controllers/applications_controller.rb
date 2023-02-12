class ApplicationsController < ApplicationController
  def welcome
  end

  def show
    # @pet = Pet.find(params[:id])
    @applicant = Application.find(params[:id])
    @pets = @applicant.pets
  end

  def create
    @new_app = Application.create!(application_params)
    @new_app.status = "In Progress"
    @new_app.update(application_params)
    redirect_to "/applications/#{@new_app.id}"
  end

  private
  
  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :reason_for_adoption, :status)
  end
end
