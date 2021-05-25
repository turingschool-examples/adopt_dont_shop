# frozen_string_literal: true

class PetitionsController < ApplicationController
  def new; end

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

    @pets = Pet.search(params[:search]) if params[:search]
    if params[:pet_id]
      new_pet = Pet.find(params[:pet_id])
      @pet_petition = PetPetition.create(petition: @petition, pet: new_pet)
      @associated_pets = PetPetition.associated_pets(@petition.id)
    end
  end

  def submit
    @petition = Petition.find(params[:id])
    @petition.goodhome = params[:goodhome]
    @petition.status = 'Pending'
    @petition.save
    redirect_to "/petitions/#{@petition.id}"
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
