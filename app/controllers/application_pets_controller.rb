class ApplicationPetsController < ApplicationController

  def show
    @applicant = Application.find(params[:id])
    @pet = Pet.find(params[:id])
  end
end