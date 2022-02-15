class Admin::ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
  end

  def update
    @application = Application.find(params[:id])
    pet_app = PetApplication.pet_app(@application.id, params[:petid])
    pet_app.status = params[:status]
    pet_app.save
    redirect_to "/admin/applications/#{@application.id}/"
  end
end
