class ApplicationsController < ApplicationController
  def index
    @applications = Application.all
  end

  def show
    @application = Application.find(params[:id])
    if params[:search].present? then @pets = Pet.search(params[:search]) end
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

  def update
    @application = Application.find(params[:id])
    if params[:pet_id] != nil
      pet = Pet.find(params[:pet_id])
      @application.pets << pet
    elsif params[:status] != nil
      @application.update(application_params)
      @application.save
    end
    redirect_to "/applications/#{@application[:id]}"
  end

  private
  def application_params
    params.permit(:first, :last, :street, :city, :state, :zip, :description, :status, :pet_id)
  end

  private
  def error_message(errors)
    errors.full_messages.join(', ')
  end
end