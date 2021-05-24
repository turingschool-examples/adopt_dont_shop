class PetApplicationsController < ApplicationController
  def show
    @pet_application = PetApplication.find(params[:id])
  end

  def new
  end

  def create
    @pet_application = PetApplication.find(params[:id])

    if @pet_application.save
      redirect_to "/pet_application/#{@pet_application.id}"
    else
      redirect_to "/pet_application/new"
      flash[:alert] = "Error: #{error_message(@pet_application.errors)}"
    end
  end

  private

  def pet_application_params
    params.permit(:id, :name, :street_address, :city, :state, :zip_code, :description, :status)
  end
end
