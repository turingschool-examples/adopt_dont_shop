class ApplicationsController < ApplicationController
  def index
  end

  def show
    # @applicant = Application.find(params[:id])
    if params[:search]
      binding.pry
      @applicant = Application.find(params[:id])
      @pets = Pet.where(name: params[:search].capitalize)
    else
      @applicant = Application.find(params[:id])
    end
    # binding.pry

    # @joins = ApplicationPet.create!(application: @applicant, pet: @pets)
    # @pet_for_applicant = ApplicationPet.where("application_id = ?", params[:id]).all
    # binding.pry
  end

  def new
    @application = Application.new
  end

  def create
    application = Application.new(application_params)
    # application = Application.create!({
    #   name: params[:name],
    #   street_address: params[:street_address],
    #   city: params[:city],
    #   state: params[:state],
    #   zip_code: params[:zip_code],
    #   description: params[:description]
    #   })
    # redirect_to "/applications/#{application.id}"
    if application.save
      redirect_to "/applications/#{application.id}"
    else
      redirect_to "/applications/new"
      flash[:alert] = "Error: #{error_message(application.errors)}"
    end
  end

  private

  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description)
  end
end
