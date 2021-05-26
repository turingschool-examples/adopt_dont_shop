class AdminApplicationsController < ApplicationController
  def index
    @applications = Application.all
  end

  def show
    @application = Application.find(params[:id])
    @pets = Pet.search(params[:pet_of_interst_name])
    @pet = @application.pets
  end
end
