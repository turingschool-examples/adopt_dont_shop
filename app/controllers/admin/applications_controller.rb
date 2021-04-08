class Admin::ApplicationsController < ApplicationController

   def show
     @application = Application.find(params[:id])
   end

  def update
    @application = Application.find(params[:id])
    @pets = @application.pets
    @pets_applied = @application.pet_applications
  end
end
