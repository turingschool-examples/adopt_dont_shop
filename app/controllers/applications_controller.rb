class ApplicationsController < ApplicationController
  def index
  end

  def show
    @application = Application.find(params[:id])
    if params[:search].present?
      @pets = Pet.search(params[:search])
    else
      @pets = @application.pets
    end
  end

  def new
  end

  def create
    application = Application.create(application_params)

    if application.save
      redirect_to "/applications/#{application.id}"
    else
      flash[:alert] = "Error: Name can't be blank, Steet can't be blank, City can't be blank, State can't be blank, Zipcode can't be blank"
      redirect_to "/applications/new"
    end
  end

private

  def application_params
    params.permit(:name, :street, :city, :state, :zip)
  end
end
