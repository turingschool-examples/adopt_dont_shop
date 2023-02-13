class AdminApplicationsController < ApplicationController 
  def show 
    
    @application = Application.find(params[:id])
    @pets = @application.pets
    @admin_decision = params[:decision]
    @button_clicked = params[:clicked]
    @pet_ids = []
    @pet_ids << params[:pet_id]
    # require 'pry'; binding.pry
  end
end