class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def new
    @application = Application.find_by(id: app_params[:application_id])
  end

  def index
    @application = Application.all
  end


  def create
    @application = Application.find_by(id: app_params[:application_id])
    application = Application.new(app_params)

    if application.save
      redirect_to "/applications/#{application.id}"
    else
      redirect_to "/applications/new"
      flash[:alert] = "Error: #{error_message(application.errors)}"
    end
  end

  private

  def app_params
    params.permit(:name, :street, :city, :state, :zip_code, :good_home,
                  :application_status)
  end
end
