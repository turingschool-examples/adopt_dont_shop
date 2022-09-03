class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    if params[:search]
      @pets = Pet.search(params[:search])
    else
      @application = Application.find(params[:id])
    end
  end

  def new
  end

  def create
    if params[:name].blank? || params[:street_address].blank? || params[:city].blank? || params[:state].blank? || params[:zipcode].blank? || params[:status].blank? || params[:description].blank?
      redirect_to "/applications/new"
      flash[:alert] = "Please fill in all fields"
    else
      application = Application.create!(applications_params)
      redirect_to "/applications/#{application.id}"
    end
  end

private
  def applications_params
    params.permit(:name, :street_address, :city, :state, :zipcode, :status, :description)
  end
end
