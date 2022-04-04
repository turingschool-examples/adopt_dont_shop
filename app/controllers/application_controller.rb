class ApplicationController < ActionController::Base
  def welcome
  end

  def index
    @applications = Application.all
  end

  def show
    # binding.pry
    @application = Application.find(params[:id])
    @pets = @application.pets
    if params[:search_for_pet_name].present?
      @searched_pets = Pet.search(params[:search_for_pet_name])
    end
  end

  def new
  end

  def create
    # binding.pry
    @application = Application.new(application_params)
    # redirect_to "/applications/#{@application.id}"
    # binding.pry
    if @application.save
      redirect_to "/applications/#{@application.id}"
    else
      redirect_to "/applications/new"
      flash[:alert] = "Error: #{error_message(@application.errors)}"
    end
  end

  private

  def error_message(errors)
    errors.full_messages.join(', ')
  end

  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description)
  end
end
