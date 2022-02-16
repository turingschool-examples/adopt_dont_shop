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
      if @application.all_pets_approved
        @application.status = "2"
        @application.save
      end
  end
end
