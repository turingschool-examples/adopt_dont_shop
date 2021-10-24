class ApplicationsController < ApplicationController
  def index
    @applications = Application.all
  end

  def new
  end

  def create
    @application = Application.new(application_params)

      if @application.save
        redirect_to "/applications/#{@application.id}"
      else
        redirect_to '/applications/new'
        flash[:alert] = "Error: #{error_message(@application.errors)}"
      end
  end

  def show
    @application = Application.find(params[:id])

    if params[:search].present?
      # (@application.application_status == "In Progress") &&
      @pets = Pet.search(params[:search])
    else
      flash.alert = "Error: no pets match your search"
    end
  end

  private

  def application_params
    params.permit(:id, :name, :street_address, :city, :state, :zip_code, :description)
  end
end
