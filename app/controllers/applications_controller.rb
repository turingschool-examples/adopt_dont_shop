class ApplicationsController < ApplicationController
  def index
  end

  def new;end

  def create
    if params.has_value?("")
      redirect_to "/applications/new"
      flash[:alert] = "Error: Please fill out all required fields"
    else
      @app = Application.create!(
        name: params[:name],
        street_address: params[:street_address],
        city: params[:city],
        state: params[:state],
        zipcode: params[:zipcode],
        status: "In Progress",
        description: "None"
      )
      redirect_to "/applications/#{@app.id}"
    end
  end

  def add_pet
    @application = Application.find(params[:id])
    pet = Pet.find(params[:pet_id])
    @application.pets.push(pet)

    redirect_to "/applications/#{@application.id}"
  end

  def show
    @applicant = Application.find(params[:id])
      if params[:pet_name]
        @pets = Pet.search(params[:pet_name])
      else
        @pets =[]
      end
      if params[:pet]!= nil
        pet = Pet.find(params[:pet])
        PetApplication.create!(pet_id: pet.id, application_id: @applicant.id)
    
    end
  end

  private
    def applications_params
      params.permit(:name, :street_address, :city, :state, :zipcode, :description, :status)
    end
end
