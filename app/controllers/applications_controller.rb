class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def new
    @status = 'In Progress'
  end

  def create
    application = Application.create(application_params)
    @last_app = Application.order('created_at').last
    redirect_to "/applications/#{@last_app.id}"
  end

  private

  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description, :status)
  end
end
