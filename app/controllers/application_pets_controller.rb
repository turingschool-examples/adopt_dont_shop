class ApplicationPetsController < ApplicationController


  def create
    #binding.pry
    application_pet = ApplicationPet.create(application_id: params[:application_id], pet_id: params[:pet_id])

    redirect_to "/applications/#{params[:application_id]}"
  end
end


private

  def app_params

  end
