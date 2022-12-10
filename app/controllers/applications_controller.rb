class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @pet_id_pairs = @application.pets.pluck(:id, :name)
    @pet_searches = []
    @pet_searches = Pet.where(name: params[:search]) if params[:search]
  end

  def new
  end

  def create
    if(Application.create(applications_params).valid?)
      @application = Application.create!(applications_params)
      redirect_to "/applications/#{@application.id}"
    else
      redirect_to "/applications/new?error=true"
    end
  end

  def update
    @application = Application.find(params[:id])
    if params[:pet]
      @pet = Pet.find(params[:pet])
      ApplicationPet.create!(application: @application, pet: @pet)
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
