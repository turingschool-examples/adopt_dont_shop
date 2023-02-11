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

  def update
    @petition = Petition.find(params[:id])
    @petition.update(petition_params)
    @petition.update_attribute(:status, 'Pending')
    redirect_to "/petitions/#{@petition.id}"
  end
  
  private

  def petition_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description, :status, :search)
  end

end

