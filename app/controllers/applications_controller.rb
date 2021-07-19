class ApplicationsController < ApplicationController
  def new
    @application = Application.new
  end

  def show
    @application = Application.find(params[:id])
  end

  def create
    application = Application.new(application_params)

    application.save

    redirect_to "/applications/#{application.id}"
  end



  private

  def application_params
    params.permit(:name, :street_address, :city, :state,
                  :zip_code, :description, :status)
  end
end
