class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @search_pet = []

    if self.params[:search_for_pet]
    #  @search_pet
    @search_pet = Pet.search(params[:search_for_pet])
    end
  end

  def new
  end

  def create
    application = Application.create(application_params)
    if application.name == "" || application.street_address == "" || application.city == "" || application.state == "" || application.zip_code == ""
      redirect_to "/applications/new"
      flash[:alert] = "Error: Please fill in all fields"
    else
      redirect_to "/applications/#{application.id}"
    end
  end

  def edit
    @application = Application.find(params[:id])
  end

  def update
    @application = Application.find(params[:id])
    if params[:pet]
      @pet = Pet.find(params[:pet])
      ApplicationPet.create!(application: @application, pet: @pet)
    end
    # application.update(application_params)
    redirect_to "/applications/#{@application.id}"
  end

  private
  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description, :id)
  end
end