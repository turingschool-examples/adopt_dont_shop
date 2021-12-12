class ApplicationsController < ApplicationController
  def index

  end

  def show
    @pets = []
    @application = Application.find(params[:id])
    adopts = AdoptablePet.all
    adopts.each do |pet|
      @pets.push(Pet.find(pet.pet_id))
    end
  end

  def edit

  end

  def new

  end
end
