class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    if params[:search].present?
      @pets = Pet.search(params[:search])
    end
  end

  def new
  end

  def create
    application = Application.new(application_params)
    if application.save
      redirect_to "/applications/#{application.id}"
    else
      flash[:alert] = "Error: #{error_message(application.errors)}"
      redirect_to "/applications/new"
    end

  end

  def update
    application = Application.find(params[:id])
    if application.status == 'In Progress'
      application.update(status:'Pending')
    end
    redirect_to "/applications/#{application.id}"
  end

  private
    def application_params
      params.permit(:name, :address, :city, :state, :zip_code, :status, :description)
    end
end
