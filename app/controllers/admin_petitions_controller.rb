class AdminPetitionsController < ApplicationController
  def show
    @petition = Petition.find(params[:id])
    @associated_pet_petitions = PetPetition.where("petition_id = ?", @petition.id)
    if params[:approval]
      @pet = Pet.find(params[:pet])
      @pet_petition = PetPetition.select(@pet.id, @petition.id)
      @pet_petition.status = params[:approval]
      @pet_petition.save
    end
  end
end
