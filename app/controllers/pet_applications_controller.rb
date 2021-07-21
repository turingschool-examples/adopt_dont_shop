class PetApplicationsController < ApplicationController
  # def index
    
  # end

  # def show
    
  # end
  
  # def new
    
  # end
  
  def create
    adopted_pet = Pet.find(params[:pet_id])
    application = Application.find(params[:id])
    application.pets << adopted_pet
    redirect_to "/applications/#{application.id}"
  end
  
  # def edit
    
  # end
  
  # def update
    
  # end
  
  # def destroy
    
  # end
  
private
  def pet_app_params
    params.permit(:name, :street_address, :description, :city, :state, :zip_code)
  end
end