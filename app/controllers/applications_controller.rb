class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def new; end

  def create
    application = Application.new(application_params)

    if application.save
      redirect_to "/applications/#{application.id}"
    else
      redirect_to "/applications/new"
      flash[:alert] = "Please provide a response for all fields."
    end
  end

  private

  def application_params
    params.permit(:name, :address, :city,
                  :state, :zipcode, :description, :status)
  end
end
