  class PetsController < ApplicationController
    def index
      @pets = Pet.adoptable
      if params[:name] && params[:breed] && params[:age]
        if params[:age] != ''
          @pets = Pet.where(["name LIKE :name and breed LIKE :breed and age = :age", { name: "%" + params[:name].capitalize + "%", breed: "%" + params[:breed] + "%", age: params[:age]}])
        else
          @pets = Pet.where(["name LIKE :name and breed LIKE :breed and age BETWEEN 0 AND 30", { name: "%" + params[:name].capitalize + "%", breed: "%" + params[:breed] + "%"}])
        end
      end
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
    Pet.destroy(params[:id])
    redirect_to '/pets'
  end

  private
  def pet_params
    params.permit(:id, :name, :age, :breed, :adoptable, :shelter_id)
  end

  private
  def error_message(errors)
    errors.full_messages.join(', ')
  end
end
