# frozen_string_literal: true

class PetitionsController < ApplicationController
  def new; end

  def create
    @petition = Petition.create(petition_params)
    redirect_to "/petitions/#{@petition.id}"
    flash[:status] = 'In Progress'
  end

  def show
    @petition = Petition.find(params[:id])
  end

  private

  def petition_params
    params.permit(
      :name,
      :street_address,
      :city,
      :state,
      :zipcode
    )
  end
end
