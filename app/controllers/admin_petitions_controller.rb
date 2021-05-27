class AdminPetitionsController < ApplicationController
  def show
    @petition = Petition.find(params[:id])
    @applied_for = PetPetition.where("petition_id = ?", @petition.id)
    @pets = @applied_for.map { |petition| petition.pet }
  end

  def approve
    petition = Petition.find(params[:id])
    pet = Pet.find(params[:pet])
    pet_petiton = PetPetition.where("pet_id = ? AND petition_id = ?", pet.id, petition.id)
    binding.pry
  end
end
