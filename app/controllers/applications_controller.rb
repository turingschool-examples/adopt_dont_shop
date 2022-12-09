class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:application_id])
    @pets = @application.pets
  end

  def new

  end

  def create
    @application = Application.new(app_params)
    if @application.save
      redirect_to "/applications/#{@application.id}"
    else
      flash[:notice] = "Application not created. Please fill out all fields."
      render :new
    end
  end

private 
  def app_params
    params.permit(:name, :street, :city, :zip, :state, :applicant_argument, :app_status)
  end
end