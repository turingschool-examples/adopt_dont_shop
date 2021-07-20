class ApplicationsController < ApplicationController
  def new
    @application = Application.new
  end

  def show
    @application = Application.find(params[:id])
    @pet_count = @application.pets.count

    if params[:search]
      @pets = Pet.adoptable.partial_search(params[:search])
    else
      @pets = []
    end
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



  private

  def application_params
    params.permit(:name, :street_address, :city, :state,
                  :zip_code, :description, :status)
  end
end
