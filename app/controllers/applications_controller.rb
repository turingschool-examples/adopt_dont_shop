class ApplicationsController < ApplicationController

  def index
  end

  def show
    @app = Application.find(params[:id])
    @pets = @app.list_pets
    @search = 0
    @pet_search = []
    if params[:search_name]
      @pet_search = Pet.search(params[:search_name])
      @search = 1
    end
  end

  def new
  end

  def create
    application = Application.new(application_params)

    if application.save
      redirect_to "/applications/#{application.id}"
    else
    flash[:notice] = "Please fill out the whole form"
    render :new
   end
  end

  def update
    application = Application.find(params[:id])
    if params[:pet_adopt_id]
      ApplicationPet.create(application_id: params[:id], pet_id: params[:pet_adopt_id])
    end
    application.update(application_params)

    redirect_to "/applications/#{application.id}"
  end

  private
  def application_params
    params.permit(:id, :name, :address, :city, :state, :zipcode, :about, :status, :search_name)
  end
end
