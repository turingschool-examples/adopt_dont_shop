class ApplicationsController < ApplicationController

  def new
    @application = Application.new
  end

  def create
    @application = Application.new(application_params)
    if @application.save 
      redirect_to "/applications/#{@application.id}"
    else
      render :new # ask instructors monday if they care about this
    end
  end

  def show
    @application = Application.find(params[:id])
    @pets = Pet.all
    @selected_pets = []
    @selected_pets = @application.pets.all unless @application.pets.all.nil?
    @search_pets = []
    @search_pets = Pet.search(params[:search]) if params[:search].present?
  end

  def update
    @application = Application.find(params[:id])
    if @application.pets.find_by(id: params[:pet]) == nil
      @application.add_pet(params[:pet])
    end

    redirect_to "/applications/#{@application.id}"
  end

private
  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description)
  end
end