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
    # binding.pry

    application = Application.create!({
      name: params[:name],
      street_address: params[:street_address],
      city: params[:city],
      state: params[:state],
      zip_code: params[:zip_code],
      description: params[:description]
      })

    redirect_to "/applications/#{application.id}"
  end
end
