class ApplicationsController < ApplicationController
  def new
    @pets = Pet.adoptable
  end

  def create
    @application = Application.new(application_params)
    if @application.save
      redirect_to "/applications/#{@application.id}"
    else
      redirect_to "/applications/new"
      flash[:notice] = "Application not submitted: Required information missing."
    end
  end

  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
    if params[:query]
      @pets = Pet.search(params[:query])
    elsif params[:pet_name]
      @pet = Pet.find(params[:pet_name])
      PetApplication.create!(pet: @pet, application: @application)
    end
  end

  private
  def application_params
    params.permit(:id, :name, :street_address, :city, :zipcode, :state, :description, :status, :pets, :created_at, :updated_at)
  end
end
