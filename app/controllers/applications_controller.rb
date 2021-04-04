class ApplicationsController < ApplicationController
  def index
      @applications = Application.all
  end
  #
  # def show
  #   @application = Application.find(params[:id])
  # end
  #
  # def new
  #   @shelter = Shelter.find(params[:shelter_id])
  # end
  #
  # def create
  #   application = Application.new(application_params)
  #
  #   if application.save
  #     redirect_to "/shelters/#{application_params[:shelter_id]}/applications"
  #   else
  #     redirect_to "/shelters/#{application_params[:shelter_id]}/applications/new"
  #     flash[:alert] = "Error: #{error_message(application.errors)}"
  #   end
  # end
  #
  # def edit
  #   @application = Application.find(params[:id])
  # end
  #
  # def update
  #   application = Application.find(params[:id])
  #   if application.update(application_params)
  #     redirect_to "/applications/#{application.id}"
  #   else
  #     redirect_to "/applications/#{application.id}/edit"
  #     flash[:alert] = "Error: #{error_message(application.errors)}"
  #   end
  # end
  #
  # def destroy
  #   Application.find(params[:id]).destroy
  #   redirect_to '/applications'
  # end

  private
  def application_params
    params.permit(:id, :name, :street_address, :city, :state, :zip_code, :description, :status)
  end
end
