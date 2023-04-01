class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
    @pets_search = Pet.where(name: params[:search])
  end
end