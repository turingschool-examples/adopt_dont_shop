class ApplicationsController < ApplicationController
  def index
    @applications = Application.all
  end

  def show
    @application = Application.find(params[:id])
  end

  def new
  end

  def create
    #new_app = Application.create(application_params)
    new_app = Application.create(    name: params[:name],     street_address: params[:street_address],     city: params[:city],     state: params[:state],     zip_code: params[:zip_code],     description: params[:description],     status: "In Progress")

    if new_app.valid?
      new_app.update(      status: "In Progress")
      redirect_to("/applications/#{new_app.id}")
    else
      flash[:notice] = "Application not Submitted. Please fill out all fields."
      redirect_to("/applications/new")
    end
  end

  private

  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description, :status)
  end
end
