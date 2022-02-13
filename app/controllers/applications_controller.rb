class ApplicationsController < ApplicationController
  def index

  end

  def show
    @application = Application.find(params[:id])
  end

  def new
  end

  def create
    @application = Application.new(
      name: params[:name],
      street_address: params[:street_address],
      city: params[:city],
      state: params[:state],
      zip_code: params[:zip_code],
      description: params[:description],
      full_address: params[:full_address],
      status: params[:status]  
    )
    @application.save
    redirect_to "/applications/#{@application.id}"
  end
end
