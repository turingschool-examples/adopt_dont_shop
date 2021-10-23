class ApplicationPetsController < ApplicationController

  def create
    application = Application.find(params[:application_id])
    application.add_pet(params[:pet_id])
    redirect_to application_path(application)
  end

end
