class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
    if params.has_key?(:search)
      @found_pets = Pet.search(params[:search])
    end
  end

  def new
  end

  def create
    application = Application.new(application_params)
    if application.save
      redirect_to "/applications/#{application.id}"
    else
      flash[:alert] = "Error(s): #{error_message(application.errors)}"
      redirect_to "/applications/new"
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
    params.permit(:name, :street, :city, :state, :zip_code, :description)
  end
end
