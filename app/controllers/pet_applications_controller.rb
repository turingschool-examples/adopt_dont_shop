class PetApplicationsController < ApplicationController
  def create
    pet_app = PetApplication.new(application_id: params[:application], pet_id: params[:pet])

    pet_app.save

    redirect_to "/applications/#{params[:application]}"
  end
end
