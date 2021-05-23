# frozen_string_literal: true

class PetitionsController < ApplicationController
  def new
  end

  def create
    @petition = Petition.new(petition_params)
    if @petition.save
      redirect_to "/petitions/#{@petition.id}"
      flash[:status] = 'In Progress'
    else
      flash[:incomplete] = ' Must Fill In All Fields'
      redirect_to '/petitions/new'
    end
  end

  def show
    @petition = Petition.find(params[:id])
    @pets = Pet.all
    if params[:search]
      @pets = Pet.search(params[:search])
    end
  end

  def add_pet
    @petition = Petition.find(params[:id])
    @pet = Pet.find(params[:id])
    
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
