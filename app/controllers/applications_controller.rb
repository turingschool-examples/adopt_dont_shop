class ApplicationsController < ApplicationController
  def welcome
  end

  def index
    @applications = Application.all
  end

  def new

  end

  def create
    application = Application.create(application_params)
    if application.save
      redirect_to "/applications/#{application.id}"
    else
      redirect_to "/applications/new"
      flash[:alert] = "Error: #{error_message(application.errors)}"
    end
  end

  def show
    if params[:pet_name].present?
      @application = Application.find(params[:id])
      @pet = Pet.search_by_name(params[:pet_name])
    else
      @application = Application.find(params[:id])
    end
  end

  #   @selected_pets = @application.pets
  #   if params[:description]
  #     @application.update({description: params[:description]})
  #     @application.save
  #   end
  #   @application.update_status
  # end

  def edit
    @application = Application.find(params[:id])
  end

  def update
    @application = Application.find(params[:id])
    if application.update(application_params)
      redirect_to "applications/#{application.id}"
    end
  end

  private

  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description, :status)
  end

  # def error_message(errors)
  #   errors.full_messages.join(', ')
  # end


end
