class ApplicationsController < ApplicationController
  def create
    application = Application.new(application_params)

    if application.save
      redirect_to "/applications/#{application.id}"
    else
      redirect_to "/pets/#{application_params[:shelter_id]}/applications/new"
      flash[:alert] = "Error: #{error_message(application.errors)}"
    end
  end

  def application_params
    params.permit(:id, :name, :address, :city, :state, :zip, :description)
  end
  
  def new
  end
end