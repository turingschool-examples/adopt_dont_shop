class ApplicationsController < ApplicationController

  def index
  end

  # if "pet_name" != nil
    #run active record query for pet_name

  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
    @has_pets = @application.has_pets?
    if params[:pet_name] != nil
      @pet_search = Pet.search_pets(params[:pet_name])
    else 
      @pet_search = []
    end
  end

  def new
  end

  def create
    application = Application.new(application_params)
    if application.valid?
      application.save     
      redirect_to "/applications/#{application.id}"
    else
      flash.now[:messages] = application.errors.full_messages
      render :new
    end
  end

  def update
    @application = Application.find(params[:id])
    @application.update(update_params)
    redirect_to "/applications/#{@application.id}"
  end

  private

  def application_params
    params.permit(:applicant_name, :app_street, :app_city, :app_state, :app_zip_code)
  end

  def update_params
    params.permit(:description, :status)
  end


end
