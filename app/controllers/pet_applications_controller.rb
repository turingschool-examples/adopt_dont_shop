class PetApplicationsController < ApplicationController

  def index
    @pet_applications = PetApplication.all
  end

  def show
    @pet_application = PetApplication.find(params[:id])
    if params[:search_for_pet]
      @matching_pet = Pet.search(params[:search_for_pet])
    end
  end

  def new
  end

  def create
    pet_application = PetApplication.new(pet_application_params)

    pet_application.save
    redirect_to "/pet_applications/#{pet_application.id}"
    # if shelter.save
    #   redirect_to '/shelters'
    # else
    #   redirect_to '/shelters/new'
    #   flash[:alert] = "Error: #{error_message(shelter.errors)}"
    # end
  end

  def edit
    @pet_application = PetApplication.find(params[id])
  end

  # def update
  #   shelter = Shelter.find(shelter_params[:id])
  #   if shelter.update(shelter_params)
  #     redirect_to '/shelters'
  #   else
  #     redirect_to "/shelters/#{shelter.id}/edit"
  #     flash[:alert] = "Error: #{error_message(shelter.errors)}"
  #   end
  # end

  def destroy
    pet_application = PetApplication.find(params[:id])
    pet_application.destroy
    redirect_to '/pet_applications'
  end

  def connect_pet_to_app
    @pet_application = PetApplication.find(params[:id])
    @pet = Pet.find(params[:pet_id])
    @pet_application.pets.push(@pet)

    redirect_to "/pet_applications/#{@pet_application.id}"
  end


  private

  def pet_application_params
    params.permit(:id, :name, :street, :city, :state, :zip, :reason)
  end
end
