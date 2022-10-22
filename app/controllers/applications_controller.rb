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
    @application = Application.new(application_params)
    if @application.save
      redirect_to "/applications/#{@application.id}"
    else 
      flash[:alert] = "Unable to complete your application, please fill out all fields"
      redirect_to "/applications/new"
    end
  end

  def edit
    @application = Application.find(params[:id])
    render "show"
  end

  private
  def application_params
    params.permit(:id, :name, :street_address, :city, :state, :zip, :status, :description)
  end
end