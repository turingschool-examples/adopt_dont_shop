class ApplicationsController < ApplicationController

  def new
    @application = Application.new
  end

  def create
    @application = Application.new(application_params)
    if @application.save 
      redirect_to "/applications/#{@application.id}"
    else
      render :new # ask instructors monday if they care about this
    end
  end

  def show
    @application = Application.find(params[:id])
    @pets = Pet.all
    @search_pets = []
    @search_pets = Pet.search(params[:search]) if params[:search].present?
  end

private
  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description)
  end
end