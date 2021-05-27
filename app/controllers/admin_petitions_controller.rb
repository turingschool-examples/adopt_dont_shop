class AdminPetitionsController < ApplicationController
  def show
    @petition = Petition.find(params[:id])
    @pets = Pet.find()
  end
end
