class ApplicationsController < ApplicationController 
  def new
    
  end

  def create
    @application = Application.create!(application_params)
    redirect_to "/applications/#{@application.id}"
  end
  
  def show
    @application = Application.find(params[:id])
    if params[:search_name].present?
      @located_pets = Pet.search(params[:search_name])
    end
  end

  private
  def application_params
    params.permit(
      :name, 
      :street_address, 
      :city,
      :state,
      :zipcode,
      :description
    )
  end

end