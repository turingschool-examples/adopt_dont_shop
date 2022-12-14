class ApplicationsController < ApplicationController

  def new
    @application = Application.new
  end

  def create
    @application = Application.new(application_params)
    if @application.save 
      redirect_to "/applications/#{@application.id}"
    else
      redirect_to "/applications/new"
      flash[:alert] = "Error: #{error_message(@application.errors)}"
    end
  end

  def show
    @application = Application.find(params[:id])
    @pets = Pet.all
    @selected_pets = @application.pets
    @search_pets = Pet.search(params[:search]) if params[:search].present?
    @status = params[:approve_reject]
    pet_app = PetApplication.find_by(pet_id: params[:pet_id])
    if @status == "accepted"
      pet_app.accepted!
    elsif @status == "rejected"
      pet_app.rejected!
    end
  end

  def update
    @application = Application.find(params[:id])
    if params[:pet] && @application.pets.find_by(id: params[:pet]).nil?
      @application.add_pet(params[:pet])
    elsif params[:commit] == "submit"
      @application.pending!
    end

    redirect_to "/applications/#{@application.id}"
  end

private
  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description)
  end
end