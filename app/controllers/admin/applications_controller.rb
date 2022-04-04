class Admin::ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
    @pets = []
    @application.pets.each {|pet| @pets << pet}
    if !params[:approve].nil?
      # require "pry"; binding.pry
      Pet.find(params[:approve]).adoptable = false
    end
  end
end
