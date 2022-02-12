class ApplicationsController < ApplicationController

def show 
    @application = Application.find(params[:id])
    @full_address = "#{@application.street_address} #{@application.city}, #{@application.state} #{@application.zipcode}"
    @applied_pets = @application.pets.all
    if params[:search]
      @pets = Pet.search(params[:search])
    end 
  end

  def new 
    @application = Application.new
  end 

  def create
    @application = Application.new(applicant_params)
    if @application.save
      redirect_to "/application/#{@application.id}"
    else 
      render :new
    end 
  end 

  def update 
    application = Application.find(params[:id])
    if params[:pet]
        pet = Pet.find(params[:pet])
        application.adopt(pet)
        redirect_to "/application/#{application.id}"
    end 
  end 

private
  def applicant_params
    params.permit(:name, :street_address, :city, :state, :zipcode, :description)
  end
end