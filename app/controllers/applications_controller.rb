class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    if params[:search].present?
      @pets = Pet.search(params[:search])
    else 
      @pets = Pet.adoptable
    end
  end
end


def index
  if params[:search].present?
    @pets = Pet.search(params[:search])
  else
    @pets = Pet.adoptable
  end
end