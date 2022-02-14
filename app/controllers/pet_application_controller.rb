class PetApplicationController < ApplicationController
  def create
    @application = Application.find(params[:id])
    @new_pet = Pet.find(params[:search])
    @pet_application = PetApplication.create!(pet: @new_pet, application: @application, approved: true)
    # binding.pry
    @pet_application.save
    redirect_to "/applications/#{@application.id}"
  end
end
