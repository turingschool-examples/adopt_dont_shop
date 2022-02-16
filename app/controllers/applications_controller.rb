class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])

    if params[:search].present?
      @pets = Pet.where(name: params[:search])
    else
      @pets = []
    end
    # @pets = @application.pets
    # @pets = Pet.find_by(name: params[:search])
    # @approved_pets = @pets.find_all {|pet| !pet.has_approved_applicant}
  end

  def new
    # @application = Application.new
  end


  def create
    # application = Application.create(application_params)
    application = Application.new(application_params)
    # application.status = "In Progress"
    application.update(status: "In Progress")
    # redirect_to "/applications/#{application.id}"
    # if application.save && params[:pet_names] != nil
    if application.save
    #   pets = Pet.where(id: params.keys)
    # application.pets << pets

      redirect_to "/applications/#{application.id}"
    else
      redirect_to "/applications/new"
      flash[:alert] = "Error: #{error_message(application.errors)}"
    end
  end

  def update
    # application = Application.find(params[:id])
    # application.update(application_params)
    # redirect_to "/applications/#{application.id}"

    application = Application.find(params[:id])
    application.pets << Pet.find(params[:pet_id])
    application.add_pet(pet)
    application.save
    redirect_to "/applications/#{application.id}"

  end

  # def search
  #   @pets = Pet.find_by(name: params[:search])
  #   redirect_to "/applications/#{params[:id]}"
  # end

private
  def application_params

    params.permit(:name, :street_address, :city, :state, :zip_code, :description, :pet_id)
    .with_defaults(status: "In Progress")
  end
end
