class PetApplications < ApplicationController

def create
  application = PetApplication.create(create_params)
  redirect_to "/pets/application/#{application.id}"
end

def show
  @application = PetApplication.find(params[:id])
end

private
  def create_params
    params.permit(:name, :address, :city, :state, :zipcode, :description)    
  end
end
