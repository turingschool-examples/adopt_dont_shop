class ApplicationsController < ApplicationController

  def create
    application = Application.new(application_params)
  end

  def show
    @application = Application.find(params[:id])
  end

  private

  def application_params
    params.permit(:first_name, :last_name, :street_address, :city, :post_code, :good_owner)
  end

end
