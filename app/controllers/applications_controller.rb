class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    if params[:search].nil?
      @pets = @application.associated_pets(params[:id])
    else
      @pets = Pet.search(params[:search])
    end
  end
end
