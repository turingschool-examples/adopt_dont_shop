class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def new
  end

  def create
    application = Application.new(application_params)


    if application.save
      redirect_to "/applications/#{application.id}"
      #why didnt the normal params work for this? or interpolation of application.id?
    else
      redirect_to "/applications/new"
      flash[:alert] = "Error #{error_message(application.errors)}"
    end

  end

  private
    def application_params
      params.permit(:name, :address, :city, :state, :zip_code, :status, :description)

    end
end
