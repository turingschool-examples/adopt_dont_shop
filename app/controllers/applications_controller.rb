class ApplicationsController < ApplicationController
  def index
    @applications = Application.all
  end

  def show
    @application = Application.find(params[:id])

    @application.pets << Pet.find(params[:pet]) if params[:pet]
    @pets = @application.pets

    if params[:search_for_pet_name].present?
      @searched_pets = Pet.search(params[:search_for_pet_name])
    else
      @searched_pets
    end
  end
  
  def new
  end

  def create
    # binding.pry
    @application = Application.new(application_params)
    if @application.save
      redirect_to "/applications/#{@application.id}"
    else
      redirect_to "/applications/new"
      flash[:alert] = "Error: #{error_message(@application.errors)}"
    end
  end


  private
  def application_params
    params.permit( :name, :street_address, :city, :state, :zip_code, :description, :status)
  end
end
