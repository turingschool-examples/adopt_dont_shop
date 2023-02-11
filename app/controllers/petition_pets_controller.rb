class PetitionPetsController < ApplicationController
  def create
    @petition = Petition.find(params[:petition_id])
    @pet = Pet.find(params[:pet_id])
    @petition_pets = PetitionPet.create(petition_pets_attributes)
    @petition_pets.save
    binding.pry
    # redirect_to "petitions/#{@petition.id}"
  end
  
  def show
  end
  
  private

  def petition_pets_attributes
    params.permit(:pet_id, :petition_id)
  end
end