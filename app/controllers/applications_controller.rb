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
  def create
    application = Application.new({
      name: params[:name],
      street_address: params[:street_address],
      city: params[:city],
      state: params[:state],
      zipcode: params[:zipcode],
      description: params[:description],
      status: params[:status]
      })
    application.save
    redirect_to "/applications/#{application.id}"
  end
end
