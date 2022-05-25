class ApplicationsController < ApplicationController

  def show
    @applications = Application.find(params[:id])
    @applications.pets << Pet.find(params[:pet]) if params[:pet]
    if params[:pet_select].present?
      @result = Pet.search(params[:pet_select])
    else
      @result
    end
  end

  def index
    @applications = Application.all
  end

  def new

  end

  def create
    application = Application.new(application_params)
    if application.save
      redirect_to "/applications/#{application.id}"
    else
      redirect_to "/applications/new"
      flash[:alert] = "Error: #{error_message(application.errors)}"
    end
  end

  def edit
  end

  def update
    application = Application.find(params[:id])
    if params[:good_owner].present?
      application.update(description: params[:good_owner], status: "Pending")
      redirect_to "/applications/#{application.id}"
    end
  end

  private

    def application_params
      params.permit(:name, :street_address, :city, :state, :zip, :description, :status)
    end
end
