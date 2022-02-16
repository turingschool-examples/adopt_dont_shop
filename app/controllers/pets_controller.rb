class PetsController < ApplicationController
  def index
    if params[:search].present?
      @pets = Pet.search(params[:search])
    else
      @pets = Pet.adoptable
    end
  end

  def show
    @pet = Pet.find(params[:id])
  end

  def new
    @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    pet = Pet.new(pet_params)

    if pet.save
      redirect_to "/shelters/#{pet_params[:shelter_id]}/pets"
    else
      redirect_to "/shelters/#{pet_params[:shelter_id]}/pets/new"
      flash[:alert] = "Error: #{error_message(pet.errors)}"
    end
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    pet = Pet.find(params[:id])
    if pet.update(pet_params)
      redirect_to "/pets/#{pet.id}"
    else
      redirect_to "/pets/#{pet.id}/edit"
      flash[:alert] = "Error: #{error_message(pet.errors)}"
    end
  end

  def destroy
    Pet.find(params[:id]).destroy
    redirect_to '/pets'
  end

  def adopt
    pets = Application.find(params[:app_id]).pets
    pets.each do |pet|
      pet.update(adoptable: false)
    end
    redirect_to "/admin/applications/#{params[:app_id]}"
  end

  private

  def pet_params
    params.permit(:id, :name, :age, :breed, :adoptable, :shelter_id)
  end
end
