class AdminApplicationsController < ApplicationController
  def show
    @applicant = Application.find(params[:id])
    @pets = @applicant.pets
  end

  def update
    require 'pry'; binding.pry
  end

end