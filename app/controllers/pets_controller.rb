  class PetsController < ApplicationController
    def index
      @pets = Pet.adoptable
      if params[:search_by_name] && params[:search_by_name] != ""
        @pets = Pet.where("name like ?", 
        "#{params[:search_by_name]}%".capitalize)
      end
      if params[:search_by_breed] && params[:search_by_breed] != ""
        @pets = Pet.where("breed like ?", 
        "%#{params[:search_by_breed]}%")
      end
      if params[:search_by_age] && params[:search_by_age] != ""
        @pets = Pet.where("age = ?",
        params[:search_by_age].to_i)
      end
      # if
      # @pets = Pet.adoptable
      # end
  end

  def show
    @pet = Pet.find(params[:id])
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

  private

  def pet_params
    params.permit(:id, :name, :age, :breed, :adoptable, :shelter_id)
  end
end
