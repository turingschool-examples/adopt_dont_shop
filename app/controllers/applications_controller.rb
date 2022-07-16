class ApplicationsController < ApplicationController 
  def new
    
  end
  
  def show
    @application = Application.find(params[:id])
    if params[:search_name].present?
      @located_pets = Pet.search(params[:search_name])
    end
  end
end