class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
    @pet_search = Pet.search_by_name(params[:pet_name])
    @application_pets = @application.pets
  end

  def new
  end

  def create
    application = Application.new(application_params)
    if application.save
      redirect_to "/applications/#{application.id}"
    else
      flash[:notice] = "Application not created: Required information missing."
      redirect_to "/applications/new"
    end  
  end

  def update
    application = Application.find(params[:id])
    application.update(description: params[:description], status: 1)
  
    redirect_to "/applications/#{params[:id]}"
  end

  private
  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description, :status)
  end
end