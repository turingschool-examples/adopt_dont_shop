class ApplicationsController < ApplicationController
  def index
    @applications = Application.all
  end

  def show
    @application = Application.find(params[:id])
    require 'pry'; binding.pry
    @pets = ApplicationPet.find(params[])
  end
end