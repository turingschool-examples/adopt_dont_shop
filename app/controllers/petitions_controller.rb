class PetitionsController < ApplicationController

  def index

  end
  
  def new
    
  end

  def create
    @petition = Petition.new(petition_params)
    if @petition.save
      redirect_to "/petitions/#{@petition.id}"
    else
      redirect_to "/petitions/new"
      flash[:alert] = "Error: #{error_message(@petition.errors)}"
    end
  end
  
  def show
    @petition = Petition.find(params[:id])
    if params[:search] != nil
      @results = Pet.search(params[:search])
    end
  end

  # def add
  #   @petition = Petition.find(params[:id])
  #   @pet = Pet.find(params[:pet_id])
  #   @petition.add_pet(@pet)
  #   binding.pry
  #   redirect_to "/petitions/#{@petition.id}"
  # end
  
  private

  def petition_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :search)
  end

end

