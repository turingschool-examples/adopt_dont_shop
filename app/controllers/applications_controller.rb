class ApplicationsController < ApplicationController

  def index
    @applications = Application.all
  end

  def new
  end

  def show
    # binding.pry
    @application = Application.find(params[:id])
    if params[:pet_name].present?
      @pets = Pet.search(params[:pet_name])
    end

    @selected_pets = @application.pets
    if params[:description]
      @applications.update({description: params[:desription]})
      @application.save
    end
    @application.status_update
  end

  def create
    application = Application.create(application_params)

    if application.save
      redirect_to "/applications/#{application.id}"
    else
      flash[:alert] = "Error"
      redirect_to "/applications/new"
    end
  end

  def update
    application = Application.update(application_params)
  end

private

  def application_params
    params.permit(:name, :address, :city, :state, :zip, :description, :status)
  end


end
