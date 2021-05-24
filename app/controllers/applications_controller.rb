class ApplicationsController < ApplicationController
  def index
    @applications = Application.all
  end

  def show
    @application = Application.find(params[:id])
    @pets = Pet.search(params[:pet_of_interst_name])
    @pet = @application.pets
  end

  def new
    # @application = Application.find(params[:id])
  end

  def create
    application = Application.create(applications_params)
    redirect_to '/applications'
  end

  def edit
    @application = Application.find(params[:id])
  end

  def update
    application = Application.new(applications_params)
  end

  def destroy
    Application.find(params[:id]).destroy
    redirect_to '/applications'
  end

  def add_pet
    @application = Application.find(params[:id])
    @pet = Pet.find(params[:pet_id])
    @application.pets << @pet
    # binding.pry
    redirect_to "/applications/#{@application.id}"
  end

  def submit_pet
    @application = Application.find(params[:id])
    @application.description = params[:description]
    @application.save
    redirect_to "/applications/#{@application.id}"
  end

  private

  def applications_params
    params.permit(:name, :address, :description, :status)
  end
end
