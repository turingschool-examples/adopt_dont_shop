class ApplicationsController < ApplicationController

  def create
    application = Application.create!(application_params)
    redirect_to "/applications/#{application.id}"
  end

  def new
    @application = Application.new
  end

  def show
    @application = Application.find(params[:id])
    if params[:search].nil?
      @pets = Pet.adoptable
    else
      @pets = Pet.search_by_name(params[:search])
    end
    @pets_adopting = @application.pets
    @source = 'applications'
  end

  private
  def application_params
    params.require(:application).permit(:name,
                  :street_address,
                  :city,
                  :state,
                  :zip_code,
                  :status)
    end
end