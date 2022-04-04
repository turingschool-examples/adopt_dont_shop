class Admin::ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
    @pets = []
    @application.pets.each {|pet| @pets << pet}
    if !params[:approve].nil?
      require "pry"; binding.pry
      @pet = Pet.find(params[:approve])
      @pet.status = false
    end
  end
end
