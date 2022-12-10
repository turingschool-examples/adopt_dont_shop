class Pets::ApplicationsController < ApplicationController
  def show
    
    @application = Application.find(params[:id])
    @adoptees = @application.pets
    @search_pets = Pet.search(params[:pet_name])
  end

  def create
    application = Application.new(create_params)
    # binding.pry
    if application.save
      redirect_to "/applications/#{application.id}"
    else
      redirect_to "/applications/new"
      flash[:notice] = "Application Not Created, Required Information Missing"
    end
  end

  private

  def create_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description, :status)
  end
end
