class ApplicationsController < ApplicationController
  
  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
    @searched_pets = Pet.search(params[:pet_name]) if !params[:pet_name].nil?
    @application.status = 'Pending' if !params[:commit].nil?
  end

  def new
  end

  def create
    application = Application.new(application_params)

    if application.save
      redirect_to "/applications/#{application.id}"
    else
      redirect_to "/applications/new"
      flash[:alert] = "Error: #{error_message(application.errors)}"
    end
  end
  
  def application_params
    params.permit(:id, :name, :address, :city, :state, :zip, :description)
  end

end