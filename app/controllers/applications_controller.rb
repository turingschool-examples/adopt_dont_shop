class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
  end

  def new
  end

  def create
    application = Application.new(application_params)

      redirect_to "/applications"
  end

private

def application_params
  params.permit(:name, :street, :city, :state, :zip)
end
end
