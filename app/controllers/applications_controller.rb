class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @found_pets = Pet.find_by(name: params[:pet])
    # require 'pry'; binding.pry
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
      flash[:notice] = "Error: #{error_message(application.errors)}"
      render :new
    end
  end

  private

  def app_params
    params.permit(:name, :street, :city, :state, :zip_code, :good_home,
                  :application_status)
  end
end
