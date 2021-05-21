class PetitionsController < ApplicationController
  def new
  end

  def create
    @petition = Petition.create(petition_params)
    redirect_to "/petitons/#{@petition.id}"
  end

  private

  def petition_params
    params.permit(
      :name,
      :street_address,
      :city,
      :state,
      :zipcode,
      :good_home
    )
  end
end
