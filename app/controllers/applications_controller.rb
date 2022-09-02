class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def new
  end

  def create
    # binding.pry
    application = Application.create!(app_params)
    redirect_to "/applications/#{application.id}"
  end

  private

  def app_params
    params.permit(:fname, :lname, :street_address, :city, :state, :zip_code, :good_home_argument, :status)
  end
end