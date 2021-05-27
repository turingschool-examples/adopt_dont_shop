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
  end

  private

  def application_params
    params.permit(:id, :name, :state, :city, :zip_code, :address).merge(status: 'In Progress')
  end
end