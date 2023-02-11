class ApplicationsController < ApplicationController
  def show
    @applicant = Application.find(params[:id])
  end

  def new 
    
  end

  def create 
    
    application = Application.new(application_params)
    application.save
    # require 'pry'; binding.pry

    redirect_to "/applications/#{application.id}" 
  end

  private 
  def application_params 
    params.permit(:name, :address, :city, :state, :zip_code,:description )
  end
end