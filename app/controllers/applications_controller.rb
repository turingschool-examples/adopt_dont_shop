class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:application_id])
    @pets = Pet.all
    if params[:search].present?
      @pets = Pet.search(params[:search])
    end
    if params[:adopt]
      @pet = Pet.find(params[:adopt])
      @application.pets << @pet
    end
  end

  def new

  end

  def create
    application = Application.new(application_params)
    if application.save
      redirect_to "/applications/#{application.id}"
    else
      redirect_to '/applications/new'
      flash[:alert] = "Error: #{error_message(application.errors)}"
    end
  end

  private

  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code)
  end
end