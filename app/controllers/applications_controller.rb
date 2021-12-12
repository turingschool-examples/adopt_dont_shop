class ApplicationsController < ApplicationController
  def index
    @applications = Application.all
  end

  def show
    @pets = []
    @application = Application.find(params[:id])
    adopts = AdoptablePet.all
    adopts.each do |pet|
      @pets.push(Pet.find(pet.pet_id))
    end
  end

  def edit

  end

  def new
  end
  def create
    adoption = Application.new(app_params)
    if adoption.save
      redirect_to "/applications/#{adoption.id}"
    else
      flash[:notice] = "Application not complete: Please fill out all sections"
      render :new
    end
  end

  private

  def app_params
    params.permit(:name, :street_address, :city, :state, :zipcode, :description, :status)
  end
end
