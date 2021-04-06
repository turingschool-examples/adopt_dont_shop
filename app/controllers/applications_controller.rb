class ApplicationsController < ApplicationController

  def create
    @application = Application.new(application_params)
    @application.status = "In Progress"
    if @application.save
      flash[:success] = "Your application is in progress"
      redirect_to "/applications/#{@application.id.to_s}"
    else
      flash[:error] = "You must fill in all fields to complete application"
      render :new
    end
  end

  def index
    @applications = Application.all
  end

  def show
    @application = Application.find(params[:id])
  end

  def edit
    @application = Application.find(params[:id])
  end

  def new
  end

  def update
  end

  private

  def application_params
    # params.permit(:id, :name, :address, :description)
    params.permit(:name, :address, :city, :state, :zip_code, :description)
  end

end