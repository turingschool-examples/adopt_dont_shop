class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
    @pets_search = Pet.where(name: params[:search])
  end

  def application_params
    params.permit(:name, :address, :city, :state, :zip, :description)
  end

  def new
    @application = Application.new
  end

  def create
    @application = Application.new(application_params)
    if @application.save
      redirect_to "/applications/#{@application.id}"
    else
      flash[:alert] = "Please fill in all required fields."
      redirect_to "/applications/new"
    end
  end

  def update
    application = Application.find(params[:id])
    application.update(status: 1)
    application.update(good_owner: params[:good_owner])
    redirect_to "/applications/#{application.id}"
  end
  
end