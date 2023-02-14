class Admin::ApplicationsController < ApplicationController

  def show
    @app = Application.find(params[:id])
  end
  
  def update
    @app = Application.find(params[:id])
    pet_application = ApplicationPet.find_application_pet(params[:pet_id], params[:id])
    pet_application.update(pet_status: params[:pet_status].to_i)

    redirect_to "/admin/applications/#{@app.id}"
  end
end