class PetitionsController < ApplicationController

  def new
    
  end

  def create
    @petition = Petition.new(pet_params)
    redirect_to "/petitions/#{@petition.id}"
  end

  private

  def petition_params
    params.permit(:id, :name, :street_address, :city, :state, :zip_code)
  end
end

  def show
    @petition = Petition.find(params[:id])
  end
end

