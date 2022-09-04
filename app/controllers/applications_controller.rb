class ApplicationsController < ApplicationController
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
      flash[:notice] = "Application not submitted: Required information missing."
    end
  end

  def show
    @application = Application.find(params[:id])
  end

  private
  def application_params
    params.permit(:id, :name, :street_address, :city, :zipcode, :state, :description, :status, :created_at, :updated_at)
  end
end
