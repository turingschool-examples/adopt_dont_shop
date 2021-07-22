class ApplicationsController < ApplicationController

  def index
  end

  def show
    @application = Application.find(params[:id])
    @pets = Pet.search("%#{params[:search]}%")
    if params[:add_pet]
      # @application.pets << Pet.find(params[:add_pet])
      ApplicationPet.create!(application_id: params[:id], pet_id: params[:add_pet], status: nil)
    end
  end


  def update
    @application = Application.find(params[:id])
    @application.update(application_params)
    redirect_to "/applications/#{@application.id}"
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

  private
  def application_params
    params.permit(:name,
                  :street_address,
                  :city,
                  :state,
                  :zip_code,
                  :description,
                  :status)
  end
end
