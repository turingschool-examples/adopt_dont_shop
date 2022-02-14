class ApplicationsController < ApplicationController


  def show
    @application = Application.find(params[:id])
  end

  def new
    @application = Application.new
  end

  def create
    # application = Application.create(application_params)
    application = Application.create(application_params)
    # application.status = "In Progress"
    # application.update(status: "In Progress")
    # redirect_to "/applications/#{application.id}"
    if application.save
      redirect_to "/applications/#{application.id}"
    else
      flash[:alert] = "Error: #{error_message(application.errors)}"
      redirect_to "/applications/new"
      # render :new
    end

  end


private
  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description)
    .with_defaults(status: "In Progress")
  end
end
