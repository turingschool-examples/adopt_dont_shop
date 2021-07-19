class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def create
    @application = Application.new(applications_params)
    if @application.save
      redirect_to "/applications/#{@application.id}"
    else
      redirect_to "/applications/new"
      flash[:alert] = "Error: #{error_message(@application.errors)}"
    end
  end

  def new
  end

  private
  def applications_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description)
  end
end
