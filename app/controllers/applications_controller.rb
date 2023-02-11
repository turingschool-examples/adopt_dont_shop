class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:application_id])
    @full_address = "#{@application.street_address} #{@application.city}, #{@application.state} #{@application.zip_code}"
    if params[:search].present?
      @pets = Pet.search(params[:search])
    else
      @pets = @application.pets
    end
  end

private
  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description, :status)
  end
end