class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
  end

  def new
  end

  def create
    params[:status] = 'In Progress'
    application = Application.create(application_params)
    if application.save
      redirect_to "/applications/#{application.id}" and return
    else
      flash[:notice] = "Error: please enter all required fields."
      redirect_to "/applications/new" and return
    end
  end

  private
  def application_params
    params.permit(:name, :address, :city, :state, :zipcode, :description, :status)
  end
end
