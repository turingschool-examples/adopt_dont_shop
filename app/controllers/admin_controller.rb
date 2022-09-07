class AdminController < ApplicationController
  def index
    @shelters = Shelter.reverse_alpha
  end

  def show
    @application = Applicant.find(params[:id])
    @pets = @application.pets
    
  end
end