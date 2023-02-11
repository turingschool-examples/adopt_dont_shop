class ApplicationsController < ApplicationController
  def welcome
  end

  def show
    # @pet = Pet.find(params[:id])
    @applicant = Application.find(params[:id])
    @pets = @applicant.pets
  end

  def create
  end

end
