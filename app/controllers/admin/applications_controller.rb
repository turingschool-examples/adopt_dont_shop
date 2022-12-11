class Admin::ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
    if params[:pet_id]
      pet = Pet.find(params[:pet_id])
      pet.adopt
      # require 'pry'; binding.pry
    end
  end
end