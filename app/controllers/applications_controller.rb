class ApplicationsController < ApplicationController

  def show
      @application = Application.find(params[:id])
  end

  def new
  end

  def create
    application = Application.create(application_params)
    if application.save
      redirect_to "/applications/#{application.id}"
    else
      redirect_to '/applications/new'
      flash[:alert] = 'Error, all fields must be completed'
    end
  end

  private

  def application_params
    params.permit(:name, :street, :city, :state, :zipcode, :description)
  end
end
