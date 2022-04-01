class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @pets = Pet.find(@application.pet_id)
    # binding.pry
  end
end
