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

  def show
    if params[:adopt].present?
      @application = Application.find(params[:id])
      @pets_to_adopt = @application.pets << Pet.find(params[:adopt])
    elsif params[:search].present?
      @application = Application.find(params[:id])
      @pets = Pet.search(params[:search])
    else
      @application = Application.find(params[:id])
    end
  end

  def new
  end

  def create
    application = Application.new(application_params)

    if application.save
      redirect_to "/applications/#{application.id}"
    else
      redirect_to '/applications/new'
      # render :action => :edit
      flash[:alert] = "Error: #{error_message(application.errors)}"
    end
  end

  def edit
    @application = Application.find(params[:id])
  end

  def update
    application = Application.find(application_params[:id])
    if application.update(application_params)
      redirect_to '/applications'
    else
      redirect_to "/applications/#{application.id}/edit"
      flash[:alert] = "Error: #{error_message(application.errors)}"
    end
  end

  def destroy
    # application = Application.find(params[:id])
    # application.destroy
    # redirect_to '/applications'
  end

  private

  def application_params
    params.permit(:applicant_name, :street, :city, :state, :zip_code, :statement, :status)
  end
end
