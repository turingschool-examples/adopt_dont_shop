class ApplicationsController < ApplicationController

  def index

  end

  def show
    @application=Application.find(params[:id])
  end

  def new
  end

  def create
    @application = Application.create(application_params)
    if @application.save
      redirect_to "/applications/#{@application.id}"
    else
      flash[:notice] = "Application not created: required information missing."
      redirect_to '/applications/new'
    end
  end

private

  def application_params
    params.permit(:name, :street_address, :city, :state, :zipcode, :status, :description, :id)
  end
end
