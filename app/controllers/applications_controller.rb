class ApplicationsController < ApplicationController

  def new
  end

  def create
    application = Application.new(application_params)
    application.update_attribute(:status, "In progress")
    application.update_attribute(:description, nil)

    if application.save
      redirect_to "/applications/#{application.id}"
    else
      flash[:alert] = "Error: #{error_message(application.errors)}"
      redirect_to applications_new_url
    end
  end

  def show
    @application = Application.find(params[:id])
    @pets = Pet.search(params[:search])
  end

  def update
    @application = Application.find(params[:id])

    if params[:description]
      @application.update_attribute(:status, "Pending")
      @application.update_attribute(:description, params[:description])
      redirect_to "/applications/#{@application.id}"
    end
  end

  private

  def application_params
    params.permit(:id, :name, :address, :description, :status)
  end
end
