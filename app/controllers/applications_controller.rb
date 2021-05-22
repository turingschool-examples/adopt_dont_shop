class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def new
    @application_pets = ApplicationPet.find(params[:application_id])
  end
end
