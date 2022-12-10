class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @pets = @application.get_pets
    @pet = Pet.search(params[:query])
  end

  def index
  end

  def create
    application = Application.new(application_params)
    if application.save
      redirect_to "/applications/#{application.id}"
    else
      flash[:notice] = "Application not created: All fields must be filled to submit."
      render :new
    end
    
  end
end

private

def application_params
  params.permit(:name, :address, :city, :state, :zipcode, :description, :status)
end
