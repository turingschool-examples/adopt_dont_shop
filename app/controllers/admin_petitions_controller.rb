class AdminPetitionsController < ApplicationController
  def show
    @petition = Petition.find(params[:id])
    @associated_pet_petitions = @petition.associated_pet_petitions
    if params[:approval]
      @pet = Pet.find(params[:pet])
      @pet_petition = PetPetition.select(@pet.id, @petition.id)
      @pet_petition.status = params[:approval]
      @pet_petition.save
    end
  end
end
