class ApplicationPetsController < ApplicationController

  def create
    # require 'pry'; binding.pry
    # ids = params[:adopted].delete('[,]')
    # application_id = ids.slice(0..3)
    # pet_app_id = ids.slice(4..10)
    application_pet = ApplicationPet.create!(pet_id: params[:pet_id], application_id: params[:application_id])
    application_pet.save
    redirect_to "/applications/#{params[:application_id]}"
  end

end
