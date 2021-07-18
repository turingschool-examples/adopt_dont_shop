class ApplicationsController < ApplicationController
  def show
    @added_pets = []
    @search_pets = []
    @application = Application.find(params[:id])
    if params[:search].nil?
      @added_pets = @application.associated_pets(params[:id])
    else
      @search_pets = Pet.search(params[:search])
    end
  end

  def new
  end

  def create
    application = Application.new(application_params)
    if application.save
      redirect_to "/applications/#{application.id}"
    else
      flash[:notice] = 'Application not created: Required information missing.'
      redirect_to '/applications/new'
    end
  end

  def update
    application = Application.find(params[:id])
    pet = Pet.find(params[:pet_id])
    application.pets << pet

    redirect_to "/applications/#{application.id}"
  end

  def application_params
    if params[:status].nil?
      params.permit(:name, :street_address, :city, :state, :zip_code, :home_description).merge(status: 'In Progress')
    else
      params.permit(:name, :street_address, :city, :state, :zip_code, :home_description)
    end
  end
end
