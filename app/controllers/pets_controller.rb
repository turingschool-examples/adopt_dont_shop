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
      flash[:alert] = "Error: #{error_message(pet.errors)}"
      redirect_to "/shelters/#{pet_params[:shelter_id]}/pets/new"
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
      flash[:alert] = "Error: #{error_message(pet.errors)}"
      redirect_to "/pets/#{pet.id}/edit"
    end
  end

  def destroy
    Pet.find(params[:id]).destroy
    redirect_to '/pets'
  end

  private

  def pet_params
    params.permit(:id, :name, :age, :breed, :adoptable, :shelter_id)
  end
end
