class ShelterPetsController < ApplicationController

  def index
    @shelter = Shelter.find(params[:shelter_id])

    if params[:sort] == 'alphabetical'
      @shelter_pets = @shelter.alphabetical_pets
    elsif params[:age]
      @shelter_pets = @shelter.shelter_pets_filtered_by_age(params[:age])
    else
      @shelter_pets = @shelter.adoptable_pets
    end
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
end