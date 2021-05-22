class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def new

  end

  def create
    application = Application.new(application_params)
    application.save
    redirect_to "/applications/#{application.id}"
    # require 'pry'; binding.pry
    # if application.save
    #   redirect_to "/applications/#{application.id}"
    # else
    #   redirect_to '/applications/new'
    #   flash[:alert] = "Error: #{error_message(application.errors)}"
    # end
  end

  private

  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code)
  end
end