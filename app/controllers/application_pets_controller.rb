class ApplicationPetsController < ApplicationController
  def create
    @application = Application.find(params[:application_id])
    # require "pry"; binding.pry
    @application.application_pets.create(application_id: params[:application_id], pet_id: params[:pets_id])

    redirect_to "/applications/#{@application.id}"
  end
end
