class PetitionsController < ApplicationController
  def show
    @petition = Petition.find(params[:id])
  end
end