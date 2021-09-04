class ApplicationsController < ApplicationController
  def new
    @app = Application.new
  end

  def create
    @app = Application.create!(application_params)
    redirect_to "/applications/#{@app.id}"
  end

  def show
    @app = Application.find(params[:id])
  end

  private

  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description, :status)
  end
end
