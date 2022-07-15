class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def new
  end

  def create
    app = Application.new(application_params)

    if app.save
      redirect_to "/applications/#{app.id}"
    else
      redirect_to "/applications/new"
      flash[:alert] = "Error: #{error_message(app.errors)}"
    end 
  end

  private

  def application_params
    params.permit(:name, :street_address, :city, :state, :zipcode, :description, :status)
  end
end
