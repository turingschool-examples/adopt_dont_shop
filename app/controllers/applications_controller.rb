class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end
# require 'pry'; binding.pry

  # def name
  #   @pet = Pet.find(params[:id])
  # end
  
end