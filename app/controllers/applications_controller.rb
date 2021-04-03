class ApplicationsController < ApplicationController
  def index
    @applications = Application.all
    # if params[:sort].present? && params[:sort] == "pet_count"
    #   @shelters = Shelter.order_by_number_of_pets
    # elsif params[:search].present?
    #   @shelters = Shelter.search(params[:search])
    # else
    # end
  end

  # def pets
  #   @shelter = Shelter.find(params[:shelter_id])
  #
  #   if params[:sort] == 'alphabetical'
  #     @shelter_pets = @shelter.alphabetical_pets
  #   elsif params[:age]
  #     @shelter_pets = @shelter.shelter_pets_filtered_by_age(params[:age])
  #   else
  #     @shelter_pets = @shelter.adoptable_pets
  #   end
  # end

  def show
    @application = Application.find(params[:id])
  end

  def new
  end

  def create
    application = Application.new(application_params)

    if application.save
      redirect_to '/applications'
    else
      redirect_to '/application/new'
      flash[:alert] = "Error: #{error_message(application.errors)}"
    end
  end

  def edit
    # @application = Application.find(params[:application_id])
  end

  def update
    # application = Application.find(application_params[:application_id])
    # if application.update(application_params)
    #   redirect_to '/applications'
    # else
    #   redirect_to "/applications/#{application.application_id}/edit"
    #   flash[:alert] = "Error: #{error_message(application.errors)}"
    # end
  end

  def destroy
    # application = Application.find(params[:id])
    # application.destroy
    # redirect_to '/applications'
  end

  private

  def application_params
    params.require(:application).permit(:application_id, :applicant_name, :street, :city, :state, :zip_code, :statement, :pet_names, :status)
  end
end
