class ApplicationsController < ApplicationController
 
  def show
    @application = Application.find(params[:id])
    @pets = Application.find_associated_pets
  end

end
