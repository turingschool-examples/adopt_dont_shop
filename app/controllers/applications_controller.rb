class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @application_pets = @application.pets
    if params[:search].present?
      @pet_searches = Pet.search(params[:search])
    end
  end

  def new
  end

  def create
    application = Application.new(applications_params)
    if application.save
      redirect_to "/applications/#{application.id}"
    else
      flash[:notice] = error_message(application.errors)
      redirect_to "/applications/new"
    end
  end

  def update
    @application = Application.find(params[:id])
    if params[:pet]
      @pet = Pet.find(params[:pet])
      ApplicationPet.create(application: @application, pet: @pet)
    end
    if params[:description]
      @application.update(description: params[:description])
      @application.update(status: "Pending")
    end
    redirect_to "/applications/#{@application.id}"
  end

  private
  def applications_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description)
  end
end
