class ApplicationsController < ApplicationController
  def index
  end

  def show
    @applicant = Application.find(params[:id])
  end

  def new
    @application = Application.new
  end

  def create
    # application = Application.new(application_params)
    application = Application.create!({
      name: params[:name],
      street_address: params[:street_address],
      city: params[:city],
      state: params[:state],
      zip_code: params[:zip_code],
      description: params[:description]
      })
    redirect_to "/applications/#{application.id}"
    # if application.save
    #   redirect_to "/applications/#{application.id}"
    # else
    #   redirect_to "/applications/new"
    #   flash[:alert] = "Error: #{error_message(application.errors)}"
    # end
  end

  private

  def application_params
    params.permit(:id, :name, :street_address, :city, :state, :zip_code, :description)
  end
end
