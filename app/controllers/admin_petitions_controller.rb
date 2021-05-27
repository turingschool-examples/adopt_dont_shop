class AdminPetitionsController < ApplicationController
  def show
    @petition = Petition.find(params[:id])
    @applied_for = PetPetition.where("petition_id = ?", @petition.id)
    @pets = @applied_for.map { |petition| petition.pet }
  end
end
