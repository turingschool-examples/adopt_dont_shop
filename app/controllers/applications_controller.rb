class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
  end

  def create
    application = Application.create(applicant_params)
    redirect_to "/application/#{application.id}"
  end


  private

  def applicant_params
    params.permit(:name, :street_address, :city, :state, :zipcode)
  end
end
