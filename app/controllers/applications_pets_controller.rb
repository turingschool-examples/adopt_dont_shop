class ApplicationsPetsController < ApplicationController


  def associate_pet_app
    # binding.pry
    app = Application.find(params[:id])
    pet = Pet.find(params[:pet_id])
    app.pets << pet
    redirect_to "/applications/#{params[:id]}"
  end
end