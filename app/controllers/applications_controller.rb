class ApplicationsController < ApplicationController
  def show 
    @application = Application.find(params[:id])
  end

  def new 
  end

  def create
    require "pry"; binding.pry
    @application = Application.new(app_params)
    if @application.save 
      redirect_to "/applications/#{@application.id}"
    end
  end

  private
  def app_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description)
  end
end