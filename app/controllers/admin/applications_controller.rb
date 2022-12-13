class Admin::ApplicationsController < ApplicationController
  def show 
    @application = Application.find(params[:id])
  end
  
  def update
    # pet = Pet.find(params[:id])
    application = Application.find(params[:id])
    application.update(status: "Approved")
    # pet.update(adoptable: false)
      redirect_to "/applications/#{application.id}"
  end
end