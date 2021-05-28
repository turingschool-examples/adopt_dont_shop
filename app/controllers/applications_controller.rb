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
  end

  def create
    application = Application.create(applications_params)
    application.status = "In Progress"
    if application.save
      redirect_to "/applications/#{application.id}"
    else
      flash[:alert] = "Error! Please fill out full form!"
      render :new
    end
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
    params.permit(:name, :address, :city, :state, :zip, :description, :status)
  end
end
