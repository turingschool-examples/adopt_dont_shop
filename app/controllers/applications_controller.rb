class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:application_id])
  end

  def create
    application = Application.new(application_params)

    application.save

    redirect_to "/applications/#{application.id}"
  end

  def new;end

  private
  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :reason, :status)
  end
end