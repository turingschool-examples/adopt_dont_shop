class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    if params[:search].present?
      @pets = Pet.search(params[:search])
    else
      @pets = []
    end
  end

  def new
    @application = Application.new
  end

  def create
    application = Application.new(application_params)
    if application.save
      redirect_to "/applications/#{application.id}"
    else
      flash[:alert] = "Error: #{error_message(application.errors)}"
      redirect_to "/applications/new"
    end
  end

  def search
    @pet = Pet.search(params[:search_pet_by_name])
    redirect_to action: :show
  end

  def update
    if params[:pet_id]
      
    elsif params[:description]
      application = Application.find(params[:id])
      application.update(application_params)
      application.Pending!
      redirect_to "/applications/#{application.id}"
    else
      flash[:alert] = "Error: you are already adopting this pet"
      redirect_to action: :show
    end
  end

  private
  def application_params
    params.permit(:name, :address, :city, :state, :zipcode, :description, :status)
  end
end
