class ApplicationsController < ApplicationController

  def index
    @applications = Application.all
  end

  def new
  end

  def create
    application = Application.new(application_params)
    if application.save
      redirect_to "/applications/#{application.id}"
    else
      flash[:notice] = "Error: Please Fill In Field"
      redirect_to "/applications/new"
    end
  end

  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
    if params[:search].present?
      @pet_names = Pet.search(params[:search])
    end
  end

  def update
    @application = Application.find(params[:id])
    @application.description = params[:description]
    @application.status = "Pending"
    @application.save
    redirect_to "/applications/#{@application.id}"
  end

  private

  def application_params
    params.permit(:id, :name, :state, :city, :zip_code, :address).merge(status: 'In Progress')
  end
end