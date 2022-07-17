class ApplicationsController < ApplicationController
  def index
  end

  def show
    # binding.pry
    @application = Application.find(params[:id])
    @pets = @application.pets
    @search = Pet.all.search(params[:search])
  end

  def new
  end

  def create
    if filled_in?(applications_params)
      redirect_to '/applications/new', notice: "Please fill all fields"
    else
      application = Application.create!(applications_params)
      redirect_to "/applications/#{application.id}"
    end
  end

  private
  def applications_params
    params.permit(:name, :address_street, :address_city, :address_state, :address_zip_code, :description, :status)

  def filled_in?(params)
    x = []
    params.each do |param|
    x << param[1].empty?
    end
    x.include?(true)
  end
end
