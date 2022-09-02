class ApplicationsController < ApplicationController
 
  def show
    @application = Application.find(params[:id])
    @pets = Application.find_associated_pets
  end

  def new
    @application = Application.find(params[:id])
  end

  def create
    #step 3 in the process - the back end
    @application = Application.find(params[:id])
    #step 4 directing the user to a diff page
    redirect_to "/applications/"  
  end

end
