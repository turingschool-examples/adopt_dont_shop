class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def new
  end

  # def create
  #   applicant = Application.create(
  #     full_name: params[:full_name],
  #     street_address: params[:street_address],
  #     city: params[:city],
  #     state: params[:state],
  #     zipcode: params[:zipcode])
  #
  #   application = ApplicationsPet.new(pet_id: nil, application_id: applicant.id, description: params[:description])
  #   binding.pry
  #   if application.save
  #     redirect_to "/applications_pets/#{application.id}"
  #   else
  #     redirect_to '/applications_pets/new'
  #     flash[:alert] = "Error: #{error_message(application.errors)}"
  #   end
  # end

  def application_params
    params.permit(:id, :full_name, :street_address, :city, :state, :zipcode, :description, :status)
  end
end
