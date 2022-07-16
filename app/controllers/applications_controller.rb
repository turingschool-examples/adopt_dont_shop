class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    if params[:search].present?
      @pets = Pet.search(params[:search])
    elsif params[:new_pet].present? 
      new_pet = Pet.find(params[:new_pet])
      ApplicationPet.create!(application: @application, pet: new_pet)
    end 
  end

  def new 

  end

  def create
    application = Application.new(application_params)
    if application.save 
      redirect_to "/applications/#{application.id}"
    else
      redirect_to '/applications/new', notice: "Please fill in all fields."
    end 
  end
  
  private 
  def application_params 
    params.permit(:name, :street_address, :city, :state, :zip_code, :description, :status, :search, :pet)
  end
end
