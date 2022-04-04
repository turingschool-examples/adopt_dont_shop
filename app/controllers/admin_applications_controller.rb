class AdminApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
    @pets = Pet.search(params[:pet_names])
  end
end
