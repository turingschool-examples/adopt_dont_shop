class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
  end

  def new

  end

  def create
    Application.create(name: params[:name],
                      address: params[:street_address],
                      city: params[:city],
                      state: params[:state],
                      zip: params[:zip_code],
                      description: params[:description],
                      status: params[:status])
    redirect_to "/applications/#{params[:id]}"
  end

end
