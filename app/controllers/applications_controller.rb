class ApplicationsController < ApplicationController

  def index
    @applications = Application.all
  end

  def show
    @application = Application.find(params[:application_id])
    @pets = @application.pets
    if params[:pets].present?
      @pets = Pet.search(params[:pets])
    end
  end

  def new
    # @application = Application.create(application_params)
    # redirect_to "/applications/#{@applicaton.id}"
  end

  def create
    application = Application.new(application_params)
    if application.save
      redirect_to "/applications/#{application.id}"
    else
      redirect_to '/applications/new'
      flash[:alert] = "Error: #{error_message(application.errors)}"
    end
  end

  # def update
  #   application = Application.find(params[:id])
  #   if application.update(application_params)
  #     redirect_to "/applications/#{application.id}"
  #   else
  #     redirect_to "/applications/#{application.id}"
  #     flash[:alert] = "Error: #{error_message(application.errors)}"
  #   end
  # end


  private

  def application_params
    params.permit(:name, :street_address, :city, :state, :zipcode, :description, :status, :pets)
  end

end
